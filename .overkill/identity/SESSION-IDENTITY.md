# Session identity (host × role × persona)

This file is **optional**. If it is **missing**, operators skip Step 0.5 in `AGENTS.md` and use historical boot behavior (Steps 0 → 1 → 2 only).

## Dimensions

| Dimension | Values | Default if unstated |
|-----------|--------|---------------------|
| **Host** | `Cursor`, `Antigravity`, `OpenClaw`, `Unknown` | `Cursor` if `.cursor/` exists at repo root; else `Unknown` |
| **Role** | `Operator`, `Execution` | `Operator` |
| **Persona** | e.g. `Forge`, or a task-scoped name | From `AGENTS.md` Live State Block (`Agent identity:`) |
| **Continuity** | `Resume` (existing thread context) / `New` (scoped task) | `Resume` |

## Execution vs Operator

- **Operator:** full boot per `AGENTS.md` (global brain, project QUICKSTART, daily logs). May read and update canonical `.overkill/memory/` per SYNC-PROTOCOL.
- **Execution:** read **only** `.overkill/execution-agent/AGENTS.md`, `HANDOFF.md`, and this repo’s code paths required by the handoff. Do **not** read canonical `.overkill/memory/MEMORY.md`, `QUICKSTART.md`, or `ARCHIVE.md` unless the orchestrator **pastes an excerpt into `HANDOFF.md`** or adds an explicit allow line to the handoff.

## Deep onboarding (rare)

Only when the orchestrator explicitly requests: read global or project **MEMORY** by **section anchor**, not as a full dump. Summarize into the **correct scoped file** (host playbook, persona notes, or handoff), not into tier-1 QUICKSTART without approval.

## Live State Block (optional lines)

At session end, the operator may add to `AGENTS.md` Live State Block:

- `Host: <Cursor|Antigravity|OpenClaw|Unknown>`
- `Session role: <Operator|Execution>`
