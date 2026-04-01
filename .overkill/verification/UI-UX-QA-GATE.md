# OverkillOS UI/UX QA Gate

Use this gate whenever a plan changes UI behavior, navigation, prompt UX, or user workflow semantics.

## Gate standard

- Evidence-first: no PASS claim without reproducible artifacts.
- Read-only QA run: do not edit code during verification.
- Severity rubric required: `high`, `medium`, `low`.
- Every finding must include:
  - reproduction steps,
  - expected behavior,
  - actual behavior,
  - suggested fix direction.
- QA run verdict may be:
  - `PASS`
  - `PASS_WITH_GAPS`
  - `FAIL`

## Hard gate mapping

OverkillOS phase gates remain binary by policy (`PASS` or `FAIL`).

- QA verdict `PASS` -> gate can pass.
- QA verdict `PASS_WITH_GAPS` -> treat gate as `FAIL` until remediation closes the listed gaps or orchestrator explicitly accepts risk for this phase.
- QA verdict `FAIL` -> gate fails.

## Mandatory coverage checklist

- Dashboard and overview surfaces.
- Per-repo workspace identity persistence across tabs.
- Diagnostics next prompt clarity and stage alignment.
- Per-repo prompts clarity, context-awareness, and operator targeting.
- Repo memory and global memory usability.
- Sync explainability and safety cues.
- Hide/archive + undo workflows (when present).

## Canonical reusable QA prompt template

```text
You are executing an OverkillOS UI/UX verification gate for <project_name> at <base_url>.

STRICT PROTOCOL:
- Read-only verification only. Do not edit code.
- Follow evidence discipline: no completion/pass claims without reproducible evidence.
- Cover all required workflows and navigation states listed below.

REQUIRED FLOW COVERAGE:
- Dashboard/overview surfaces
- Repo workspace tab persistence and title clarity
- Diagnostics next-prompt clarity and stage/step correctness
- Prompt generation UX clarity, context-awareness, and operator targeting
- Repo + global memory UX behavior
- Sync UX safety/explainability
- Hide/archive/undo flows (if available)

OUTPUT FORMAT (MANDATORY):
1) Findings ordered by severity: high -> medium -> low
2) For each finding include:
   - Reproduction
   - Expected
   - Actual
   - Suggested fix direction
3) Explicit QA verdict: PASS | PASS_WITH_GAPS | FAIL
4) Remediation checklist for all non-pass findings
5) Residual risk note (if any)

CONTEXT PACKAGE:
- Product/phase: <phase_name>
- Critical workflows to prioritize: <workflow_list>
- Repos/routes in scope: <routes_or_areas>
```

## Evidence artifact requirement

Store gate output in project docs/memory/progress artifacts and reference exact file paths in completion reports.
