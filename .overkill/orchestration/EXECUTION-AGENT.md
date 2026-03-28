# Execution Agent Policy

Rules for worker (Execution Agent) AIs dispatched by the Operator.

## Scope

- Execution agents receive a **scoped handoff** produced from `HANDOFF-TEMPLATE.md`.
- They work **only** within that scope. Out-of-scope changes are out of policy unless the operator issues a new handoff.

## Memory and context

- They **do not** read main `.overkill/memory/` files (canonical project memory).
- They **do not** update `QUICKSTART`, `MEMORY`, or `ARCHIVE` in the main memory tree.
- They **may** write to `.overkill/execution-agent/memory/` for their own continuity and scratch notes.

## Authority

- They **do not** make architectural or product decisions. They implement, investigate, or report within the handoff.
- They **report results** to the operator; the operator integrates after review.

## Integration

- The operator reviews worker output before it becomes canonical project truth or is merged into main memory.
