# Cross-IDE adaptation (Cursor, Antigravity, OpenClaw)

The `.overkill/` engine is **markdown-first** and platform-agnostic. Each IDE needs only an **entry point** and optional **rules/workflows** so the same boot order and gates apply.

| IDE | Entry point | Rules / automation |
|-----|-------------|--------------------|
| **Cursor** | Repo root `AGENTS.md` | `.cursor/rules/overkill-*.mdc` |
| **OpenClaw** (VPS, Telegram, etc.) | Workspace `AGENTS.md` + terminal | Clone/pull repo; read `~/.overkill/memory/QUICKSTART.md`; host playbook `~/.overkill/hosts/openclaw.md` |
| **Antigravity** | No auto-load of `AGENTS.md` like Cursor | **Customizations** (Global / Workspace rules) + **Workflows** (Global / Workspace). No custom MCP required — paste boot instructions there |

## Cursor (primary)

- Full boot: [AGENTS.md](../AGENTS.md) Step 0 → optional 0.5 → 1 → 2.
- Host file: `.overkill/hosts/cursor.md` when present.

## OpenClaw

- Treat repo root as workspace; ensure `AGENTS.md` and `.overkill/` exist (clone from GitHub or sync from template).
- Prefer **`~/.overkill/hosts/openclaw.md`** for headless quirks (paths, `git`, CI, no `.cursor/`).
- Global brain: same `~/.overkill/` as other tools on that machine (or sync backup repo).

## Antigravity

- Copy the **boot excerpt** from `AGENTS.md` (Steps 0, 0.5, 2) into **Workspace Customizations** for the project, and optionally a shorter variant into **Global Customizations** if you want every workspace to inherit OverkillOS culture.
- Add a **Workflow** (e.g. `overkill-boot`) that tells the agent to read global QUICKSTART, `SESSION-IDENTITY`, `.overkill/identity/SOUL.md`, project `QUICKSTART`, and daily logs before coding — mirroring Cursor behavior.
- See **`adapters/antigravity/README.md`** for paste-ready structure and [antigravity-agent-plan](../antigravity-agent-plan) (local PRD draft).

## Canonical reference

Upstream template also documents expansion paths: **`overkill-os/docs/ADAPTING.md`** (in the **overkill-os** repository).
