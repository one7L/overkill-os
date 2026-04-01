# Current plan — OverkillOS template (maintainer anchor)

> **Purpose:** Align `overkill-os` releases with the living roadmap (multi-IDE, stage-machine diagnostics, GTM pillar, control-plane UI).

**Template version:** see `VERSION`, `CHANGELOG.md`, and `init.sh`.

---

## Locked in (1.2.x baseline)

- Multi-surface identity (`SESSION-IDENTITY`, `hosts/`)
- Execution boundaries and role separation
- `overkill-sync.sh` + managed manifest model
- Cross-IDE adapters and runbook docs
- SDLC map with pillar-specific rigor + integration checkpoints

## Parity cross-check against original identity/sync plans

| Planned capability | Status | Evidence |
|--------------------|--------|----------|
| Conditional Step 0.5 boot | Implemented | `AGENTS.md` |
| Host playbooks + global hosts path | Implemented | `.overkill/hosts/*`, `global/hosts/*` |
| Execution allow/deny boundaries | Implemented | `.overkill/execution-agent/AGENTS.md` |
| Managed-file sync for existing repos | Implemented | `scripts/overkill-sync.sh`, `scripts/MANAGED-FILES.txt` |
| Downstream propagation model | Implemented | `docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md` |

## 1.3 execution focus

1. Diagnostic Protocol Spec v1 (`docs/DIAGNOSTIC-PROTOCOL.md`)
2. Honest CLI diagnostics (`scripts/overkill-diagnose.sh`)
3. Strict pre-PRD four-pillar gating in PRD workflow
4. Hybrid department operators (`General`, `DB`, `BE`, `FE`, `GTM`)
5. Safe propagation to `overkillos-origins`, `roofcalc-app`, `Pocket.HQ`, and `~/.overkill`

## Downstream rule

Projects pull template updates and run `scripts/overkill-sync.sh`; `AGENTS.md` boot sections remain manual-merge due per-repo Live State differences.

---

_Orchestrator-facing narrative anchor: `overkillos-origins/docs/CURRENT-PLAN.md`._
