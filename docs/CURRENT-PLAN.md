# Current plan — OverkillOS template (maintainer anchor)

> **Purpose:** Align **overkill-os** releases with the **living roadmap** (multi-IDE, GTM pillar, control-plane UI). Consumer projects may copy or fork this file into `docs/`. **overkillos-origins** holds a narrative variant: same version in `VERSION` / `CHANGELOG.md`.

**This template version:** see root `VERSION` and `CHANGELOG.md`.

---

## Locked in (1.2.x)

- Multi-surface identity, `hosts/`, `overkill-sync.sh`, adapters, SDLC map, operator runbook, cross-IDE docs
- No auto-sync of per-project `AGENTS.md` (Live State); manifest in `scripts/MANAGED-FILES.txt`
- Pillar rigor varies by domain; **integration checkpoints** prevent silo drift (`docs/OVERKILL-SDLC-MAP.md`)

## Next template evolution (candidates)

1. Optional **`gtm-prd.md`** template + `prd/WORKFLOW.md` hook
2. **`sync-all` helper** (optional) — list of target paths for batch sync
3. **UI / Tauri** — `docs/TAURI-PRODUCT-PLAN.md` when ready
4. **Stricter MANAGED-FILES** opt-in for `ROLES.md` / `SYNC-PROTOCOL` when safe

## Downstream

Projects (**roofcalc-app**, **Pocket.HQ**, etc.) should run `scripts/overkill-sync.sh` after pulling `main` and **manually merge** `AGENTS.md` boot sections when needed.

---

_For orchestrator-facing narrative and “bigger plan” prompts, see **overkillos-origins** `docs/CURRENT-PLAN.md` if available._
