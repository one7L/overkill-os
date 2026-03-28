# PRD Pipeline Workflow

This document describes the full research-to-PRD process for OverkillOS projects. It assumes the templates in this directory (`project-workflow.md`, `frontend-prd.md`, `backend-prd.md`, `database-prd.md`) are the standard outputs.

## 1. Four-Pillar Intake

Complete `project-workflow.md` with the four pillars: Tech Stack, Competitors, Features, and Target Audience. This step forces explicit decisions about platform constraints and differentiation before deep research. Treat the intake as the single structured source for "what we think we know" on day one; gaps are expected and drive step 2.

Do not skip sections. Placeholders should be replaced or explicitly marked as unknown with a follow-up task. The orchestrator should confirm intake completeness before funding a larger research pass.

## 2. Research Phase

Gather technical documentation, competitive materials, and user evidence (interviews, support logs, surveys) to validate or correct the intake. Prefer primary sources and reproducible notes over opinion. Competitive analysis should map features to the competitor template in the intake so PRDs stay traceable to research.

Research outputs should be linkable (URLs, file paths, interview IDs). Contradictions with the intake must be resolved in writing before PRD generation, or the intake must be revised with version notes.

## 3. PRD Generation

Produce three PRDs from the four pillars and research: **Frontend PRD** (`frontend-prd.md`), **Backend PRD** (`backend-prd.md`), and **Database PRD** (`database-prd.md`). Each PRD should reference stack choices, user-facing scope, and data needs from the intake without inventing silent requirements.

Cross-PRD consistency matters: routes and API contracts, auth flows, and schema boundaries should align. One owner (or orchestrator review) should run a consistency pass before review.

## 4. Review and Approval

The orchestrator reviews the three PRDs for feasibility, risk, and fit to scope. Agents or contributors refine sections based on feedback; changes should be summarized so approval is auditable. Approval means the PRDs are the implementation contract until formally amended.

Unresolved disagreements escalate per `protocols/ESCALATION.md` rather than shipping ambiguous PRDs.

## 5. Implementation Tracking

During build-out, mark completed items and track progress against the PRDs (checkboxes, linked issues, or a single tracking doc). When implementation diverges from a PRD, either update the PRD with rationale or treat the change as scope that requires orchestrator approval.

Closing epics or phases without mapping to PRD acceptance criteria breaks traceability; avoid it.
