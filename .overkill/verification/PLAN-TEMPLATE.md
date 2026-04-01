# [PLAN NAME]

## Reconciliation Summary

_If merging multiple plans, document what is primary vs governance. If single plan, state "Single-source plan, no reconciliation needed."_

## Single Execution Order (Source of Truth)

_Mermaid flowchart showing: Phase0 -> Gate0 -> Phase1 -> Gate1 -> ... -> GateN_

_This is the ONLY execution sequence. No parallel tracks unless explicitly gated._

## Execution Tracks

_Numbered phases with concrete deliverables:_

1. **Phase 0: [Name]** -- [deliverable]
2. **Phase 1: [Name]** -- [deliverable]
3. _(continue as needed)_

## Hardened Criteria (Mandatory Gates)

_Cross-cutting rules that apply to ALL phases:_

- No regression on previously passing properties
- Evidence artifacts required before phase closeout
- [domain-specific criteria]

## Gate Definitions (Hard Pass/Fail)

### Gate 0 -- [Name]

- **When it fires:** [trigger condition]
- **Pass criteria:** [exact, measurable conditions]
- **What blocks advancement:** [specific failure modes]

### Gate N -- [Name]

- **When it fires:** [trigger condition]
- **Pass criteria:** [exact, measurable conditions]
- **What blocks advancement:** [specific failure modes]

_(Repeat for each gate.)_

### UI/UX Gate -- [Name]

- **When it fires:** after any UI/navigation/workflow change and before phase closeout.
- **Pass criteria:** UI/UX QA artifact exists and follows `.overkill/verification/UI-UX-QA-GATE.md`; QA verdict is `PASS`; no unaddressed high/medium findings.
- **What blocks advancement:** missing QA artifact, QA verdict `PASS_WITH_GAPS` without accepted remediation/risk decision, or QA verdict `FAIL`.

## Files of Record

_Canonical paths where truth lives for this plan._

## Golden Fixture / Benchmark

_The canonical reference used at multiple gates. If none, state "No golden fixture for this plan."_

## Explicit Scope Freeze

_What is NOT in scope for this execution line. Be specific._
