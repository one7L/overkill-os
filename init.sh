#!/usr/bin/env bash
set -euo pipefail

OVERKILL_VERSION="1.4.0"
GLOBAL_BRAIN="$HOME/.overkill"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPEND_BEGIN="<!-- BEGIN:overkillos-boot-block -->"
APPEND_END="<!-- END:overkillos-boot-block -->"

print_header() {
  echo ""
  echo "OverkillOS Installer v${OVERKILL_VERSION}"
  echo "========================================"
  echo ""
}

print_step() {
  printf "  -> %-50s [%s]\n" "$1" "$2"
}

print_error() {
  echo "ERROR: $1" >&2
  exit 1
}

upsert_control_plane_repo() {
  local control_plane_root="$HOME/github/overkillOS-app"
  local control_plane_config="$control_plane_root/config/repos.json"
  local control_plane_backup="$control_plane_root/config/repos.json.bak"
  local upsert_status="skipped"

  if [[ "$TARGET" == "$control_plane_root" ]]; then
    echo "  UI registry update: skipped (target is overkillOS-app)"
    return 0
  fi

  if [[ ! -d "$control_plane_root" ]]; then
    echo "  UI registry update: skipped (overkillOS-app not found at $control_plane_root)"
    return 0
  fi

  if [[ ! -f "$control_plane_config" ]]; then
    echo "  UI registry update: skipped (missing $control_plane_config)"
    return 0
  fi

  cp "$control_plane_config" "$control_plane_backup"

  if upsert_status="$(TARGET_PROJECT_PATH="$TARGET" TARGET_PROJECT_NAME="$PROJECT_NAME" CONTROL_PLANE_CONFIG="$control_plane_config" node <<'EOF'
const fs = require("node:fs");
const path = require("node:path");

const configPath = process.env.CONTROL_PLANE_CONFIG;
const projectPath = path.resolve(process.env.TARGET_PROJECT_PATH || "");
const projectName = String(process.env.TARGET_PROJECT_NAME || "project").trim();

const toId = (value) =>
  value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");

const fallbackId = toId(projectName) || "project";
const fallbackLabel = projectName;

const raw = fs.readFileSync(configPath, "utf8");
const parsed = JSON.parse(raw);
const repos = Array.isArray(parsed.repos) ? parsed.repos : [];

const exists = repos.some((repo) => path.resolve(String(repo.root || "")) === projectPath);
if (exists) {
  process.stdout.write("exists");
  process.exit(0);
}

const existingIds = new Set(repos.map((repo) => String(repo.id || "").trim()).filter(Boolean));
let nextId = fallbackId;
let suffix = 1;
while (existingIds.has(nextId)) {
  suffix += 1;
  nextId = `${fallbackId}-${suffix}`;
}

repos.push({
  id: nextId,
  label: fallbackLabel,
  root: projectPath,
});

parsed.repos = repos;
fs.writeFileSync(configPath, `${JSON.stringify(parsed, null, 2)}\n`, "utf8");
process.stdout.write("added");
EOF
  )"; then
    echo "  UI registry update: $upsert_status"
  else
    cp "$control_plane_backup" "$control_plane_config"
    echo "  UI registry update: skipped (failed to parse/update config/repos.json)"
  fi
}

usage() {
  echo "Usage: $0 [TARGET_PROJECT_PATH]"
  echo ""
  echo "Install OverkillOS into a project directory."
  echo "If no path is given, installs into the current directory."
  echo ""
  echo "First run:  creates ~/.overkill/ global brain from templates."
  echo "Every run:  copies .overkill/ engine + AGENTS.md + .cursor/rules/ into the target."
  exit 0
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
fi

TARGET="${1:-.}"
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || print_error "Target directory does not exist: ${1:-.}"
PROJECT_NAME="$(basename "$TARGET")"

print_header
echo "Target: $TARGET"
echo ""

# ── Global Brain ────────────────────────────────────────────────────

if [[ -d "$GLOBAL_BRAIN" ]]; then
  AGENT_NAME="unknown"
  USER_NAME="unknown"
  PROJECT_COUNT=0

  if [[ -f "$GLOBAL_BRAIN/IDENTITY.md" ]]; then
    AGENT_NAME=$(grep -m1 '^\*\*Name:\*\*\|^- Name:' "$GLOBAL_BRAIN/IDENTITY.md" 2>/dev/null \
      | sed 's/.*: *//' | sed 's/\*//g' || echo "unknown")
  fi
  if [[ -f "$GLOBAL_BRAIN/USER.md" ]]; then
    USER_NAME=$(grep -m1 '^\*\*Name:\*\*\|^- Name:' "$GLOBAL_BRAIN/USER.md" 2>/dev/null \
      | sed 's/.*: *//' | sed 's/\*//g' || echo "unknown")
  fi
  if [[ -f "$GLOBAL_BRAIN/projects/registry.md" ]]; then
    PROJECT_COUNT=$(grep -c '^|' "$GLOBAL_BRAIN/projects/registry.md" 2>/dev/null || echo 0)
    PROJECT_COUNT=$((PROJECT_COUNT > 2 ? PROJECT_COUNT - 2 : 0))
  fi

  echo "Global Brain: FOUND at $GLOBAL_BRAIN"
  echo "  Agent: $AGENT_NAME"
  echo "  User:  $USER_NAME"
  echo "  Projects on file: $PROJECT_COUNT"
else
  echo "Global Brain: NOT FOUND at $GLOBAL_BRAIN"
  print_step "Creating $GLOBAL_BRAIN from templates..." "creating"
  mkdir -p "$GLOBAL_BRAIN/projects"
  mkdir -p "$GLOBAL_BRAIN/memory"
  cp "$SCRIPT_DIR/global/IDENTITY.md"   "$GLOBAL_BRAIN/IDENTITY.md"
  cp "$SCRIPT_DIR/global/USER.md"       "$GLOBAL_BRAIN/USER.md"
  cp "$SCRIPT_DIR/global/SOUL-BASE.md"  "$GLOBAL_BRAIN/SOUL-BASE.md"
  cp "$SCRIPT_DIR/global/LEARNINGS.md"  "$GLOBAL_BRAIN/LEARNINGS.md"
  cp "$SCRIPT_DIR/global/projects/registry.md" "$GLOBAL_BRAIN/projects/registry.md"
  cp "$SCRIPT_DIR/global/memory/QUICKSTART.md" "$GLOBAL_BRAIN/memory/QUICKSTART.md"
  cp "$SCRIPT_DIR/global/memory/MEMORY.md"     "$GLOBAL_BRAIN/memory/MEMORY.md"
  cp "$SCRIPT_DIR/global/memory/ARCHIVE.md"    "$GLOBAL_BRAIN/memory/ARCHIVE.md"
  if [[ -d "$SCRIPT_DIR/global/hosts" ]]; then
    mkdir -p "$GLOBAL_BRAIN/hosts"
    cp "$SCRIPT_DIR/global/hosts"/*.md "$GLOBAL_BRAIN/hosts/" 2>/dev/null || true
  fi
  print_step "Global brain created (with memory cascade)" "done"
  echo "  This is your first OverkillOS project."
fi

echo ""
echo "Per-Project Install:"

# ── .overkill/ Engine ───────────────────────────────────────────────

if [[ -d "$TARGET/.overkill" ]]; then
  print_error ".overkill/ already exists in $TARGET. Remove it first or use a different target."
fi

cp -R "$SCRIPT_DIR/.overkill" "$TARGET/.overkill"
print_step ".overkill/" "created"

# ── AGENTS.md ───────────────────────────────────────────────────────

if [[ -f "$TARGET/AGENTS.md" ]]; then
  echo ""
  echo "  WARNING: AGENTS.md already exists in $TARGET."
  if grep -q "$APPEND_BEGIN" "$TARGET/AGENTS.md"; then
    echo "  Existing OverkillOS boot block marker found. Skipping append."
    print_step "AGENTS.md" "unchanged"
  else
    echo "  Appending OverkillOS boot block to the end."
    {
      echo ""
      echo "$APPEND_BEGIN"
      echo ""
      echo "---"
      echo ""
      cat "$SCRIPT_DIR/AGENTS.md"
      echo ""
      echo "$APPEND_END"
      echo ""
    } >> "$TARGET/AGENTS.md"
    print_step "AGENTS.md" "appended"
  fi
else
  cp "$SCRIPT_DIR/AGENTS.md" "$TARGET/AGENTS.md"
  print_step "AGENTS.md" "created"
fi

# ── .cursor/rules/ ──────────────────────────────────────────────────

mkdir -p "$TARGET/.cursor/rules"
for rule in "$SCRIPT_DIR/.cursor/rules/"*.mdc; do
  rule_name="$(basename "$rule")"
  cp "$rule" "$TARGET/.cursor/rules/$rule_name"
done
print_step ".cursor/rules/overkill-*.mdc" "created"

# ── Project Registry ────────────────────────────────────────────────

REGISTRY="$GLOBAL_BRAIN/projects/registry.md"
TODAY="$(date +%Y-%m-%d)"

if ! grep -q "| $PROJECT_NAME " "$REGISTRY" 2>/dev/null; then
  echo "| $PROJECT_NAME | $TARGET | active | -- | $TODAY | $TODAY |" >> "$REGISTRY"
fi

mkdir -p "$GLOBAL_BRAIN/projects/$PROJECT_NAME"

print_step "Registered in ~/.overkill/projects/registry.md" "$PROJECT_NAME"
upsert_control_plane_repo

# ── Summary ─────────────────────────────────────────────────────────

echo ""
echo "What happens next:"
echo "  1. Open this project in Cursor"
echo "  2. Type anything -- the agent will self-initiate"

if [[ -f "$GLOBAL_BRAIN/IDENTITY.md" ]] && grep -q '\[set during bootstrap\]' "$GLOBAL_BRAIN/IDENTITY.md" 2>/dev/null; then
  echo "  3. FIRST-EVER mode: full identity negotiation (name, persona, vibe)"
else
  echo "  3. RETURNING USER mode: agent already knows you, skips identity setup"
fi

echo "  4. Then: codebase audit + PRD verification + context materialization"
echo ""
