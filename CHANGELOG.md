# Changelog

All notable changes to the **OverkillOS** template repository (`overkill-os`) are documented here. Version matches `OVERKILL_VERSION` in `init.sh` and `VERSION`.

## [1.2.0] — 2026-03-30

### Added

- **`docs/OVERKILL-SDLC-MAP.md`** — Pillar rigor (FE / BE / DB / GTM), integration checkpoints, cross-cutting concerns (security, observability, release), GTM placement, dependency ordering.
- **`.overkill/protocols/SDLC-MAP.md`** — Pointer to the SDLC map doc.
- **`docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md`** — How to propagate template updates to existing repos via `scripts/overkill-sync.sh` (without re-running `init.sh`).
- **`docs/CROSS-IDE-ADAPTATION.md`** — Cursor, Antigravity, OpenClaw entry patterns.
- **`.overkill/identity/SESSION-IDENTITY.md`** — Optional host × role × persona continuity (Step 0.5 in `AGENTS.md`).
- **`.overkill/hosts/`** — Host playbooks (`cursor`, `antigravity`, `openclaw`) + `global/hosts/` for first-time `~/.overkill/hosts/` on global brain creation.
- **`adapters/`** — READMEs per IDE / surface.
- **`scripts/overkill-sync.sh`** + **`scripts/MANAGED-FILES.txt`** — Managed-file sync for existing checkouts (`AGENTS.md` excluded from manifest to preserve per-repo Live State).
- **`VERSION`** — Single-line release number for tooling and docs.

### Changed

- **`AGENTS.md`** — Step 0.5 (optional session identity + host playbook + execution short-circuit). Backward compatible when optional files are absent.
- **`execution-agent/AGENTS.md`** — Explicit allow / forbid paths for workers.
- **`.cursor/rules/overkill-session-boot.mdc`** — Optional read of `hosts/cursor.md`.
- **`orchestration/ROLES.md`** — Host and surface cross-links.
- **`memory/*`**, **`docs/ADAPTING.md`** — References to runbook, SDLC map, sync protocol.

### Notes

- **No single enterprise playbook** — this template encodes rigorous *process*; organizations vary. The SDLC map ties pillars to gates without duplicating identical checks everywhere.
- Upgrading from **1.1.x**: pull `main`, run `scripts/overkill-sync.sh` toward each project, **manually merge** `AGENTS.md` boot paragraphs if you want parity with the template Live State block structure.

## [1.1.0] — 2026-03-30 (prior)

- Global brain first-install: copy **`global/hosts/*.md`** into **`~/.overkill/hosts/`** when creating `~/.overkill/`.
- Multi-surface identity, sync tooling, adapters, and docs above landed in development leading to **1.2.0** release tagging.

## [1.0.0] — initial

- Template installer `init.sh`, `.overkill/` engine, `AGENTS.md`, `.cursor/rules/`, global brain bootstrap.
