# Session identity (host × role × persona × department)

This file is **optional**. If it is **missing**, operators skip Step 0.5 in `AGENTS.md` and use historical boot behavior (Steps 0 → 1 → 2 only).

## Dimensions

| Dimension | Values | Default if unstated |
|-----------|--------|---------------------|
| **Host** | `Cursor`, `Antigravity`, `OpenClaw`, `Unknown` | `Cursor` if `.cursor/` exists at repo root; else `Unknown` |
| **Role** | `Operator`, `Execution` | `Operator` |
| **Persona** | e.g. `Forge`, or a task-scoped name | From `AGENTS.md` Live State Block (`Agent identity:`) |
| **Department** | `General`, `DB`, `BE`, `FE`, `GTM` | `General` |
| **Continuity** | `Resume` (existing thread context) / `New` (scoped task) | `Resume` |

## Department routing

- `General`: discovery, parity checks, broad planning, cross-cutting coordination.
- `DB`: schema, migrations, constraints, performance, RLS/data integrity.
- `BE`: services, APIs, auth/authz, contracts, integration logic.
- `FE`: UX flows, component behavior, accessibility, frontend performance.
- `GTM`: positioning, channels, experiments, messaging, launch-readiness artifacts.

Use diagnostics output to pick the next department. Department can change per session without changing persona.

## Execution vs Operator

- **Operator:** full boot per `AGENTS.md` (global brain, project QUICKSTART, daily logs). May read/update canonical `.overkill/memory/` per SYNC-PROTOCOL.
- **Execution:** read only `.overkill/execution-agent/AGENTS.md`, `HANDOFF.md`, and code paths required by handoff. Do not read canonical project memory tiers unless explicitly allowed in handoff.

## Deep onboarding (rare)

Only when orchestrator explicitly requests: read global/project MEMORY by section anchor (not full dump). Save synthesis to scoped files (host playbook, department memory, or handoff).

## Live State Block (optional lines)

- `Host: <Cursor|Antigravity|OpenClaw|Unknown>`
- `Session role: <Operator|Execution>`
- `Department: <General|DB|BE|FE|GTM>`
