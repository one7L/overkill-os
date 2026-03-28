#!/usr/bin/env bash
set -euo pipefail

OVERKILL_VERSION="1.0.0"
GLOBAL_BRAIN="$HOME/.overkill"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
  cp "$SCRIPT_DIR/global/IDENTITY.md"   "$GLOBAL_BRAIN/IDENTITY.md"
  cp "$SCRIPT_DIR/global/USER.md"       "$GLOBAL_BRAIN/USER.md"
  cp "$SCRIPT_DIR/global/SOUL-BASE.md"  "$GLOBAL_BRAIN/SOUL-BASE.md"
  cp "$SCRIPT_DIR/global/LEARNINGS.md"  "$GLOBAL_BRAIN/LEARNINGS.md"
  cp "$SCRIPT_DIR/global/projects/registry.md" "$GLOBAL_BRAIN/projects/registry.md"
  print_step "Global brain created" "done"
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
  echo "  Appending OverkillOS boot block to the end."
  echo "" >> "$TARGET/AGENTS.md"
  echo "---" >> "$TARGET/AGENTS.md"
  echo "" >> "$TARGET/AGENTS.md"
  cat "$SCRIPT_DIR/AGENTS.md" >> "$TARGET/AGENTS.md"
  print_step "AGENTS.md" "appended"
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
