# No-Regression Contract

## Principle

Once a property has passed a gate, it must continue to pass in all subsequent phases that fall under the same execution line. An advancing codebase that breaks previously guaranteed behavior is worse than a stalled one.

## Before Phase Closeout

Before closing **any** phase:

1. Re-run all gate checks that have previously passed for this plan (or the subset mandated by the plan's hardened criteria).
2. Confirm results against the same pass criteria as originally defined.
3. Record outcomes in evidence rows where the plan requires it.

Skipping re-validation to "save time" violates this contract.

## On Regression

If a regression is detected:

1. **STOP.** Do not treat the phase or downstream gates as complete.
2. Fix the regression before advancing the execution order.
3. Record a dedicated evidence row for the regression and for the fix (see `EVIDENCE-ROW.md`).

## Scope of Policy

The no-regression policy applies to:

- Automated and manual **test results**
- **Metrics** and SLOs asserted at gates
- **Behavioral properties** (API contracts, UX guarantees, security properties)
- **Performance thresholds** where they are gate criteria

## Non-Negotiable

Waiving no-regression requires an explicit orchestrator decision and a documented change to the plan or scope (for example, a retired guarantee). Silent drift is not allowed.
