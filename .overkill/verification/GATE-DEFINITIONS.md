# Gate Definitions (OverkillOS Verification)

This document defines how verification gates behave across OverkillOS plans. Use it alongside plan-specific gate sections in `PLAN-TEMPLATE.md` and evidence in `EVIDENCE-ROW.md`.

## Binary Outcomes

Gates are binary: **PASS** or **FAIL**. There is no partial pass, soft pass, or "pass with notes." Notes belong in the evidence row; the gate outcome remains one bit.

## Required Elements Per Gate

Every gate must specify all of the following:

1. **Trigger condition** -- When the gate is evaluated (e.g., end of phase, on merge, before release).
2. **Pass criteria** -- Exact, measurable conditions that must all be true for PASS.
3. **Failure mode** -- What constitutes FAIL (which checks fail, which thresholds breach).
4. **Blocking behavior** -- That a FAIL prevents any downstream phase from starting or completing as "done."

If any element is missing, the gate is undefined and must be completed before the plan is executable.

## Propagation of Failure

A failing gate blocks **all** downstream phases in the single execution order. Work may continue only on fixing the failure or on explicitly out-of-scope items if the orchestrator allows; it does not advance the gated execution line.

## Regression

Regression on a previously passing gate is treated as a **new failure** at the gate where the property was last asserted. The codebase does not "keep" PASS by history alone; each phase closeout re-validates per `NO-REGRESSION.md`.

## Roles

- **Operator** -- Runs checks, collects artifacts, reports PASS or FAIL and attaches evidence.
- **Orchestrator** -- On FAIL, decides whether to retry, redesign the plan, or abandon the line. The operator does not unilaterally waive a gate.

## Evidence

Gate results are recorded as evidence rows (see `EVIDENCE-ROW.md`). A gate without a recorded outcome for a given run is not closed.
