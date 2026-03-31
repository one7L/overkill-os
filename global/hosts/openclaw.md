# Host: OpenClaw

Typical use: headless workspace, VPS, or messaging bridge — **no** `.cursor/` folder.

## Boot

- Clone or pull the repo so `AGENTS.md` and `.overkill/` exist at workspace root.
- Read `~/.overkill/memory/QUICKSTART.md` first (global Step 0).
- Use **absolute paths** appropriate to the server (`$HOME`, project root).

## Strengths

- GitHub access: clone, pull, branch; run the same `scripts/overkill-sync.sh` as local after template updates.
- Terminal: tests, builds, CI.

## Isolation

- Execution agents on OpenClaw still follow `.overkill/execution-agent/AGENTS.md` boundaries; do not broaden reads without orchestrator approval.
