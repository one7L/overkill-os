# Scope Freeze Protocol

Use a scope freeze to pause or protect parts of the workstream during critical phases (releases, gate sequences, audits) and to prevent uncontrolled scope creep.

## Declaring a Freeze

When the orchestrator declares a scope freeze, document all of the following in writing (daily log, plan addendum, or dedicated freeze note):

1. **What is frozen** -- Repos, modules, features, APIs, schemas, or documents that must not change without an unfreeze decision.
2. **Why** -- Release lock, verification gate, dependency on external review, stability window, etc.
3. **When it can be unfrozen** -- Date, event (e.g., "after Gate 2 PASS"), or explicit orchestrator action.
4. **What remains active** -- Bugfixes allowed only for listed gates, documentation updates, ops tasks, parallel tracks explicitly exempted.

## Rules While Frozen

- Frozen scope **cannot** be modified (features, contracts, schema shape, behavior) until the orchestrator **explicitly unfrozes** it or amends the freeze document.
- Emergency changes require orchestrator approval and a retroactive update to the freeze record explaining the exception.
- Agents and operators do not interpret "small change" as exempt; the freeze list is authoritative.

## Unfreezing

Unfreeze only through a clear orchestrator decision recorded with date and scope. If the plan or PRDs change during freeze, treat that as a governed change (PRD amendment + traceability), not as silent drift.

## Relation to Plans

Align freeze boundaries with the **Explicit Scope Freeze** section of the active Overkill plan (`verification/PLAN-TEMPLATE.md`) so execution order and governance stay consistent.
