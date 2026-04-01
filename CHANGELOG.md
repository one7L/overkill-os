# Changelog

All notable changes to the **OverkillOS** template repository (`overkill-os`) are documented here. Version matches `OVERKILL_VERSION` in `init.sh` and `VERSION`.

## [1.4.0] — 2026-04-01

### Added

- **`.overkill/verification/UI-UX-QA-GATE.md`** strict reusable UI/UX verification gate template:
  - required read-only QA behavior,
  - severity-ranked findings with repro/expected/actual/fix direction,
  - explicit verdict rubric (`PASS`, `PASS_WITH_GAPS`, `FAIL`),
  - mandatory workflow coverage checklist.

### Changed

- **`.overkill/verification/GATE-DEFINITIONS.md`** now defines required UI/UX gate mapping (`PASS_WITH_GAPS` blocks advancement until remediation or explicit risk acceptance).
- **`.overkill/verification/PLAN-TEMPLATE.md`** now includes a hardened UI/UX gate definition block for plan authors.
- **`.overkill/operators/fe/QUICKSTART.md`** now requires running the UI/UX gate and recording evidence.
- **`docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md`** now includes UI/UX gate verification and references the new gate template.
- **`scripts/MANAGED-FILES.txt`** now includes verification gate files so they propagate to existing repos via `overkill-sync.sh`.
- **`README.md`**, **`VERSION`**, and **`init.sh`** aligned to `1.4.0`.

## [1.3.0] — 2026-03-30

### Added

- **`docs/DIAGNOSTIC-PROTOCOL.md`** + **`.overkill/protocols/DIAGNOSTIC-PROTOCOL.md`** pointer for stage-machine diagnostics source of truth.
- **`scripts/overkill-diagnose.sh`** to report stage, blockers, warnings, recommended department/IDE, and next prompt with persisted logs under `.overkill/logs/`.
- **`.overkill/operators/{db,be,fe,gtm}/`** scaffolds (`QUICKSTART.md`, `MEMORY.md`, `HANDOFF.md`) for hybrid departmental operator depth.

### Changed

- **`AGENTS.md` Step 0.5** now supports `Department` routing and optional department quickstart load (while preserving execution short-circuit boundaries).
- **`.overkill/identity/SESSION-IDENTITY.md`** extended from host/role/persona to host/role/persona/department continuity.
- **`.overkill/prd/WORKFLOW.md`** now explicitly enforces the four-pillar pre-PRD gate:
  - `Competitor + TargetAudience + Features + TechStack => PRD synthesis allowed`.
- **`scripts/MANAGED-FILES.txt`** expanded with diagnostic protocol files, operator scaffolds, and CLI diagnostic script.
- **`docs/OVERKILL-SDLC-MAP.md`** now includes explicit stage-machine mapping and pre-PRD hard gate note.

### Notes

- `AGENTS.md` remains manual-merge for existing repos (not auto-synced) to protect per-repo Live State blocks.
- Existing repos require `scripts/overkill-sync.sh` + optional `--backup` for propagation.

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
