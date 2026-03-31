# Host playbooks

**Purpose:** Small, host-specific notes (tools, paths, boot quirks). **Not** a second project MEMORY.

## Locations

- **In repo:** `.overkill/hosts/<host>.md` — versioned with the project.
- **On machine:** `~/.overkill/hosts/<host>.md` — for agents that start **without** this repo open (e.g. OpenClaw on a VPS). Keep in sync with template or run your template’s host sync script.

Hosts: `cursor`, `antigravity`, `openclaw` (lowercase filenames).

## Sync

After editing template host files, copy to global brain:

```bash
mkdir -p ~/.overkill/hosts
cp .overkill/hosts/*.md ~/.overkill/hosts/
```

See [docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md](../../docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md).
