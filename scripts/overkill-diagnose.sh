#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
FULL=0
LOG_ROOT=".overkill/logs"

for arg in "$@"; do
  case "$arg" in
    --full) FULL=1 ;;
    --root=*) ROOT="${arg#*=}" ;;
    *) ;;
  esac
done

cd "$ROOT"

TS="$(date -u +%Y-%m-%dT%H-%M-%SZ)"
OUT_DIR="$LOG_ROOT/diagnostics"
OUT_FILE="$OUT_DIR/$TS.md"
INDEX_FILE="$LOG_ROOT/DIAGNOSTICS.md"
mkdir -p "$OUT_DIR"

pass=0
warn=0
fail=0
skip=0

results=()

check_file() {
  local path="$1"
  local label="$2"
  if [[ -f "$path" ]]; then
    results+=("PASS|$label|$path")
    pass=$((pass+1))
  else
    results+=("HARD_FAIL|$label|$path")
    fail=$((fail+1))
  fi
}

check_heading() {
  local path="$1"
  local heading="$2"
  local label="$3"
  if [[ ! -f "$path" ]]; then
    results+=("HARD_FAIL|$label|$path")
    fail=$((fail+1))
    return
  fi
  if grep -Fqi "## $heading" "$path"; then
    results+=("PASS|$label|$path")
    pass=$((pass+1))
  else
    results+=("HARD_FAIL|$label|$path")
    fail=$((fail+1))
  fi
}

warn_if_contains() {
  local path="$1"
  local needle="$2"
  local label="$3"
  if [[ ! -f "$path" ]]; then
    return
  fi
  if grep -Fq "$needle" "$path"; then
    results+=("WARN|$label|$path")
    warn=$((warn+1))
  else
    results+=("PASS|$label|$path")
    pass=$((pass+1))
  fi
}

check_file "AGENTS.md" "root boot entry"
check_file ".overkill/identity/SOUL.md" "project soul"
check_file ".overkill/identity/SESSION-IDENTITY.md" "session identity"
check_file ".overkill/execution-agent/AGENTS.md" "execution boundary policy"
check_file ".overkill/prd/WORKFLOW.md" "prd workflow"
check_file "docs/OVERKILL-SDLC-MAP.md" "sdlc map"
check_file "docs/CURRENT-PLAN.md" "current plan anchor"

# Pre-PRD pillar readiness
for f in \
  ".overkill/prd/project-workflow.md" \
  ".overkill/prd/frontend-prd.md" \
  ".overkill/prd/backend-prd.md" \
  ".overkill/prd/database-prd.md"
do
  if [[ -f "$f" ]]; then
    results+=("PASS|pillar/prd artifact|$f")
    pass=$((pass+1))
  else
    results+=("HARD_FAIL|pillar/prd artifact missing|$f")
    fail=$((fail+1))
  fi
done

# Strict heading checks: Pre-PRD intake
check_heading ".overkill/prd/project-workflow.md" "Section 1: Tech Stack" "pre-prd heading: tech stack"
check_heading ".overkill/prd/project-workflow.md" "Section 2: Competitor Features" "pre-prd heading: competitor features"
check_heading ".overkill/prd/project-workflow.md" "Section 3: Features" "pre-prd heading: features"
check_heading ".overkill/prd/project-workflow.md" "Section 4: Target Audience" "pre-prd heading: target audience"

# Strict heading checks: PRD templates
check_heading ".overkill/prd/frontend-prd.md" "Overview" "frontend-prd heading: overview"
check_heading ".overkill/prd/frontend-prd.md" "Tech Stack" "frontend-prd heading: tech stack"
check_heading ".overkill/prd/frontend-prd.md" "Pages / Routes" "frontend-prd heading: pages/routes"
check_heading ".overkill/prd/frontend-prd.md" "Component Architecture" "frontend-prd heading: component architecture"
check_heading ".overkill/prd/frontend-prd.md" "State Management" "frontend-prd heading: state management"

check_heading ".overkill/prd/backend-prd.md" "Overview" "backend-prd heading: overview"
check_heading ".overkill/prd/backend-prd.md" "Tech Stack" "backend-prd heading: tech stack"
check_heading ".overkill/prd/backend-prd.md" "API Endpoints (RESTful or GraphQL)" "backend-prd heading: api endpoints"
check_heading ".overkill/prd/backend-prd.md" "Authentication / Authorization" "backend-prd heading: auth"
check_heading ".overkill/prd/backend-prd.md" "Business Logic" "backend-prd heading: business logic"

check_heading ".overkill/prd/database-prd.md" "Overview" "database-prd heading: overview"
check_heading ".overkill/prd/database-prd.md" "Database Choice (with Rationale)" "database-prd heading: db choice"
check_heading ".overkill/prd/database-prd.md" "Schema Design (Tables / Collections)" "database-prd heading: schema design"
check_heading ".overkill/prd/database-prd.md" "Indexes" "database-prd heading: indexes"
check_heading ".overkill/prd/database-prd.md" "Migrations Strategy" "database-prd heading: migrations"

if [[ -f ".overkill/prd/gtm-prd.md" ]]; then
  check_heading ".overkill/prd/gtm-prd.md" "Overview" "gtm-prd heading: overview"
  check_heading ".overkill/prd/gtm-prd.md" "Positioning" "gtm-prd heading: positioning"
  check_heading ".overkill/prd/gtm-prd.md" "Launch Plan" "gtm-prd heading: launch plan"
else
  results+=("SKIP|gtm-prd checks not active|.overkill/prd/gtm-prd.md")
  skip=$((skip+1))
fi

# Template freshness checks (partial/stale -> WARN)
warn_if_contains ".overkill/prd/project-workflow.md" "_Placeholder:" "pre-prd contains unresolved placeholders"
warn_if_contains ".overkill/prd/frontend-prd.md" "[Product / Initiative Name]" "frontend-prd still uses template placeholder"
warn_if_contains ".overkill/prd/backend-prd.md" "[Product / Initiative Name]" "backend-prd still uses template placeholder"
warn_if_contains ".overkill/prd/database-prd.md" "[Product / Initiative Name]" "database-prd still uses template placeholder"

# Stage heuristics (deterministic file-presence based MVP)
current_stage="Stage0_Intake"
next_stage="Stage1_CompetitorResearch"
if [[ -f ".overkill/prd/project-workflow.md" ]]; then
  current_stage="Stage1_TechStack"
  next_stage="Stage2_PRDSynthesis"
fi
if [[ -f ".overkill/prd/frontend-prd.md" && -f ".overkill/prd/backend-prd.md" && -f ".overkill/prd/database-prd.md" ]]; then
  current_stage="Stage2_PRDSynthesis"
  next_stage="Stage3_ContractsAndPrep"
fi

recommended_department="CTO"
recommended_ide="Cursor"
if [[ "$next_stage" == "Stage3_ContractsAndPrep" || "$next_stage" == "Stage4_BuildAndVerify" ]]; then
  recommended_department="BE"
fi
if [[ "$next_stage" == "Stage6_GTMReady" ]]; then
  recommended_department="GTM"
fi

overall="GREEN"
if (( fail > 0 )); then
  overall="RED"
elif (( warn > 0 )); then
  overall="YELLOW"
fi

{
  echo "# OverkillOS diagnostic"
  echo
  echo "- Time (UTC): $TS"
  echo "- Mode: $([[ $FULL -eq 1 ]] && echo full || echo fast)"
  echo "- Repo (basename): $(basename "$ROOT")"
  echo "- Root: $ROOT"
  echo "- Overall: $overall"
  echo "- Current stage: $current_stage"
  echo "- Next stage: $next_stage"
  echo "- Recommended department: $recommended_department"
  echo "- Recommended IDE: $recommended_ide"
  echo
  echo "## Results"
  echo
  echo "| Result | Check | Path |"
  echo "|--------|-------|------|"
  for r in "${results[@]}"; do
    IFS='|' read -r kind label path <<<"$r"
    printf '| %s | %s | `%s` |\n' "$kind" "$label" "$path"
  done
  echo
  echo "## Next prompt"
  echo
  echo "Use this in your next operator chat:"
  echo
  echo "\`\`\`text"
  echo "You are Forge. Host: $recommended_ide. Role: Operator. Department: $recommended_department. Continuity: Resume."
  echo "Run Step 0/0.5/2 boot, then execute next stage: $next_stage."
  echo "\`\`\`"
} > "$OUT_FILE"

mkdir -p "$(dirname "$INDEX_FILE")"
if [[ ! -f "$INDEX_FILE" ]]; then
  echo "# Diagnostic runs" > "$INDEX_FILE"
  echo >> "$INDEX_FILE"
fi
printf -- "- %s — %s (%s)\n" "$TS" "$overall" "$OUT_FILE" >> "$INDEX_FILE"

printf "Overall: %s | Stage: %s -> %s | Report: %s\n" "$overall" "$current_stage" "$next_stage" "$OUT_FILE"
