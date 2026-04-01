# Operator runbook — template updates and downstream repos

Use this whenever **overkill-os** (canonical template) gains new OverkillOS engine files (boot, hosts, execution policy, Cursor rules, sync manifest).

**Important:** Starting a **new Cursor chat** only loads **what is already on disk** in that repo and in `~/.overkill/`. It does **not** pull Git changes by itself. Propagate template updates **before** relying on a fresh chat.

---

## 1. Update the canonical template

- Work in **`~/github/overkill-os`** (or your clone of the template).
- Merge or commit changes to `.overkill/`, `AGENTS.md`, `.cursor/rules/`, `scripts/`, `adapters/`, `global/hosts/` as needed.
- Optionally bump `OVERKILL_VERSION` in `init.sh` when you cut a recognizable template release.

---

## 2. Propagate to existing projects (do not re-run `init.sh` blindly)

`init.sh` **refuses** to install if `.overkill/` already exists in the target directory. For **roofcalc-app**, **Pocket.HQ**, **overkillos-origins**, and other live repos, use **`scripts/overkill-sync.sh`** from **overkill-os** (or from **overkillos-origins** after parity):

```bash
cd /path/to/overkill-os   # or overkillos-origins if scripts live there
./scripts/overkill-sync.sh --source . --target /path/to/roofcalc-app --dry-run
./scripts/overkill-sync.sh --source . --target /path/to/roofcalc-app --backup
```

Repeat for each repo: `pocket-hq`, `overkillos-origins`, etc.

**Managed files** are listed in `scripts/MANAGED-FILES.txt`. That list **excludes** project-owned tiers (canonical `MEMORY.md`, `QUICKSTART`, `ARCHIVE`, `daily/`, `HANDOFF.md`, customized `SOUL.md`) unless you deliberately add them.

**`AGENTS.md` is not auto-synced** (each repo has a different Live State Block). When the template updates boot steps, **manually merge** Step 0.5 and related paragraphs from `overkill-os/AGENTS.md` into your project’s `AGENTS.md`.

Optional: create **`.overkill/.sync-ignore`** in a target repo (one pattern per line) to skip specific managed paths if that repo forked a file.

---

## 3. Sync global brain host playbooks (optional but recommended)

After template updates to **host** files (`global/hosts/` or `.overkill/hosts/`):

```bash
# If your template provides a helper (example — adjust path):
./scripts/sync-global-host-playbooks.sh
# or copy manually:
mkdir -p ~/.overkill/hosts
cp /path/to/overkill-os/global/hosts/*.md ~/.overkill/hosts/
```

OpenClaw/VPS and headless agents read **`~/.overkill/hosts/<host>.md`** without opening a Cursor repo.

---

## 4. Commit and push

- **Per project:** commit the synced files in `roofcalc-app`, Pocket.HQ, etc.
- **Global backup:** if `~/.overkill/` is a git repo (e.g. **OverkillOS-Origin-Backup**), commit and push so cloud backup matches your machine.

---

## 4.5 Canonical ownership and promotion flow

Use this sequence to avoid drift across local brain, template, downstream repos, and mirrors.

1. **Local brain first (`~/.overkill/`)**
   - Update source-of-truth docs and guardrails here first.
   - Validate wording/protocols before propagation.
2. **Back-propagate to canonical template (`overkill-os`)**
   - Port accepted changes into template-managed files.
   - Update release metadata (`VERSION`, `init.sh`, `README.md`, `CHANGELOG.md`) if cutting a template increment.
3. **Propagate to downstream repos**
   - Run `scripts/overkill-sync.sh --dry-run` then `--backup` from template.
   - Keep `AGENTS.md` manual merge policy.
4. **Push remotes only after approval**
   - Push template repo first, then downstream repos, then optional backup mirrors.
   - Include evidence artifact paths in push/PR notes.

---

## 5. Verify with a new chat (smoke test)

For **each** updated repo, open a **new** agent chat and confirm:

| Check | Pass criteria |
|-------|----------------|
| Operator boot | Step 0 global QUICKSTART + Step 2 project reads; optional Step 0.5 if `SESSION-IDENTITY.md` exists |
| No drift | Live State Block aligns with `.overkill/memory/QUICKSTART.md` where applicable |
| Execution agent | In an execution-only chat: reads **only** `.overkill/execution-agent/*` + `HANDOFF.md` + code per handoff — not canonical `.overkill/memory/MEMORY.md` |
| UI/UX gate | Run the strict UI/UX verification gate from `.overkill/verification/UI-UX-QA-GATE.md`; record verdict + evidence path before completion claim |

---

## Quick reference — paths

| Role | Canonical template | Global brain | Notes |
|------|---------------------|--------------|--------|
| Source of truth | `overkill-os` repo | `~/.overkill/` | Template sync does not replace global automatically |
| roofcalc / Pocket.HQ | Sync via `overkill-sync.sh` | Same `~/.overkill/` on your Mac | One machine, one global brain unless you intentionally clone |

---

## Related docs

- [CROSS-IDE-ADAPTATION.md](CROSS-IDE-ADAPTATION.md) — Cursor, Antigravity, OpenClaw entry points
- [README.md](README.md) — docs folder index
- `.overkill/verification/UI-UX-QA-GATE.md` — strict reusable browser QA gate template and verdict rubric
- `.overkill/identity/SESSION-IDENTITY.md` — host / role / persona defaults
