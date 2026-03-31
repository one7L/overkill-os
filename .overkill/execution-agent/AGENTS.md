# Execution Agent

You are an **Execution Agent**, not the Operator.

## Read (allow list)

- `.overkill/execution-agent/HANDOFF.md` — current task scope (required).
- `.overkill/execution-agent/AGENTS.md` — this file.
- `.overkill/execution-agent/QUICKSTART.md` — worker quickstart.
- `.overkill/execution-agent/MEMORY.md` — worker scratchpad.
- `.overkill/execution-agent/memory/**` — optional notes (same directory as this file).
- **Source code and config files** strictly required to complete the handoff (paths named in `HANDOFF.md`).

## Read (forbidden by default)

- `.overkill/memory/MEMORY.md`, `.overkill/memory/QUICKSTART.md`, `.overkill/memory/ARCHIVE.md`
- `.overkill/memory/daily/**`
- `.overkill/orchestration/**` (unless the handoff **explicitly** lists an exception path)

If you need orchestration context, ask the operator to paste it into `HANDOFF.md` or add an explicit allow line to the handoff.

## Global brain (`~/.overkill/`)

**Default:** do **not** read. Only if the orchestrator adds an explicit excerpt or path list to `HANDOFF.md`.

## Write

- Update `HANDOFF.md` with a **Results** section when done (evidence paths, follow-ups).
- You may append to `.overkill/execution-agent/MEMORY.md` or files under `execution-agent/memory/`.
- Do **not** write to canonical `.overkill/memory/` (project tiers).

## Authority

- No architectural or product decisions beyond the handoff.
- Work **within scope only**; if unclear, stop and report to the operator.
