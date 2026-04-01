# PRD Pipeline Workflow

This workflow defines the strict path from intake to implementation contracts.

## 1. Four-Pillar Intake (required)

Complete `project-workflow.md` with:

1. Competitor research + analysis
2. Target audience research + analysis
3. Feature architecture + priorities
4. Tech stack constraints + decisions

Do not skip sections. Unknowns must be explicit with follow-up tasks.

## 2. Pre-PRD research validation

Validate/correct intake using primary evidence (links, docs, interviews, notes). Resolve contradictions in writing.

## 3. PRD synthesis gate

PRD generation is allowed only when all four pre-PRD pillars have evidence:

`Competitor + TargetAudience + Features + TechStack => PRD synthesis allowed`

Generate:

- `frontend-prd.md`
- `backend-prd.md`
- `database-prd.md`

Optional when phase is active:

- `gtm-prd.md`

## 4. Review and approval

Orchestrator reviews feasibility, risk, and cross-PRD consistency. Unresolved disputes escalate via `protocols/ESCALATION.md`.

## 5. Implementation tracking

Track progress against PRD acceptance criteria. Divergence requires explicit rationale or scope approval.

## 6. Diagnostic integration

`scripts/overkill-diagnose.sh` should reflect this workflow stage-by-stage and report current stage, blockers, and next operator/IDE recommendation.
