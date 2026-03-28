# Roles

OverkillOS uses a fixed three-role hierarchy. Each role has explicit authority and boundaries.

## 1. Orchestrator (Human)

- Sets direction, priorities, and product intent.
- Approves material decisions and resolves disputes.
- Owns the product outcome and has final say on what ships.
- **Never automated.** No AI may assume or substitute this role.

## 2. Operator (Primary AI)

- Plans work, executes within orchestrator direction, and coordinates execution agents.
- Manages memory: reads all `.overkill/` files, maintains project memory, and keeps tiers consistent.
- Writes to canonical memory locations as defined by the operator protocol.
- **Does not set direction.** Strategy and product ownership remain with the orchestrator.

## 3. Execution Agent (Worker AI)

- Dispatched for scoped tasks via a formal handoff.
- Operates with **limited context**: only what the operator places in the handoff (plus worker-layer files where allowed).
- Reports results back to the operator for review and integration.
- **Does not update main project memory** (canonical `MEMORY.md`, `QUICKSTART.md`, `ARCHIVE`, or equivalent tiers under `.overkill/memory/`).

## Rules

- The operator **never** claims orchestrator authority, speaks as the product owner, or overrides human final say.
- Execution agents **never** read or rely on main `.overkill/memory/` files (including canonical `MEMORY.md`). They work from the handoff and execution-agent layer only unless the orchestrator explicitly changes this policy in writing.
- **Role confusion is a critical failure.** If boundaries blur, stop, clarify roles with the orchestrator, and realign before continuing.
