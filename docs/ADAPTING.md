# Adapting OverkillOS to Other Platforms

The `.overkill/` core is pure markdown -- platform-agnostic by nature. Adapting to another IDE requires writing one entry-point file that maps to `.overkill/`.

---

## Cursor IDE (Primary -- Built and Tested)

**Entry point:** `AGENTS.md` at repo root (auto-loaded by Cursor)
**Rule reinforcement:** `.cursor/rules/overkill-*.mdc`
**How it works:** Cursor injects `AGENTS.md` content into every conversation. The boot sequence and Live State Block are embedded directly in this file.

This is the platform OverkillOS is designed for. Everything else below is a documented expansion path.

---

## Claude Code (Future Expansion)

**Entry point:** `CLAUDE.md` at repo root (auto-loaded by Claude Code)

To adapt:
1. Create `CLAUDE.md` that mirrors the AGENTS.md boot sequence
2. Map the three-step boot to CLAUDE.md conventions
3. The `.overkill/` directory and all its contents work unchanged
4. Claude Code does not have a `.cursor/rules/` equivalent -- all instructions go in `CLAUDE.md`

Template structure for `CLAUDE.md`:

```markdown
# OverkillOS -- Claude Code Entry Point

[Live State Block -- same format as AGENTS.md]

## Session Boot
[Same three-step boot: global brain detection, bootstrap detection, four-file read]

## Role Definition
[Same orchestrator/operator/execution triad]

## Write Triggers
[Same event-based memory writes]

## References
- Memory cascade: .overkill/memory/SYNC-PROTOCOL.md
- Verification: .overkill/verification/
```

---

## OpenClaw (Future Expansion)

**Entry point:** Workspace `AGENTS.md` (OpenClaw convention)

OpenClaw already uses an AGENTS.md-based system with SOUL.md, USER.md, MEMORY.md, and daily logs. The OverkillOS `.overkill/` structure extends this with:

- Three-tier memory cascade (OpenClaw uses two tiers)
- Verification engine (gates, evidence rows, no-regression)
- PRD pipeline (four-pillar intake)
- Global brain (cross-project memory)

To adapt:
1. Map OpenClaw's workspace root files to `.overkill/identity/`
2. Replace OpenClaw's MEMORY.md with the three-tier cascade
3. Add `.overkill/verification/` and `.overkill/prd/` directories
4. Configure global brain at `~/.overkill/` or use OpenClaw's existing profile system

---

## Generic AI IDE (Future Expansion)

**Entry point:** `AI-AGENT.md` at repo root

For any AI IDE that loads a root-level markdown file as context:

1. Create `AI-AGENT.md` with the boot sequence
2. Point to `.overkill/` for all referenced files
3. If the IDE has a rule/convention system, create platform-specific rule files

The `.overkill/` directory works unchanged across all platforms. Only the entry-point file and any platform-specific rule injection need to be written.

---

## Tauri Desktop App (Future Product)

The file-based template described above is the personal tool. The commercial product is a native Tauri desktop application that compiles all OverkillOS logic into a Rust binary and exposes it via a local MCP server on `localhost:7017`.

With the Tauri app:
- IDEs connect via MCP tools (`overkill_boot`, `overkill_write`, `overkill_gate`, etc.)
- The agent never reads raw `.overkill/` files -- it receives computed context from the engine
- File contents are encrypted at rest
- The same MCP server serves Cursor, Claude Code, OpenClaw, and any MCP-compatible IDE simultaneously

See `docs/TAURI-PRODUCT-PLAN.md` for the full product plan, architecture, development phases, and distribution strategy.

---

## Operator runbook and downstream sync

When the **template** (`overkill-os`) gains new engine files, use **`docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md`** and **`scripts/overkill-sync.sh`** to refresh **existing** project checkouts without re-running `init.sh` on a tree that already has `.overkill/`. See also **`docs/CROSS-IDE-ADAPTATION.md`**.

**SDLC / multi-pillar alignment:** See **`docs/OVERKILL-SDLC-MAP.md`** (pillars, gates, integration checkpoints, where GTM plugs in). Pointer: `.overkill/protocols/SDLC-MAP.md`.

**Stage diagnostics:** See **`docs/DIAGNOSTIC-PROTOCOL.md`** and `.overkill/protocols/DIAGNOSTIC-PROTOCOL.md` (pointer).

**Roadmap anchor:** **`docs/CURRENT-PLAN.md`** (template maintainer); consumer repos may mirror or fork for local planning.

## Key Principle

The core engine (`.overkill/`) never changes between platforms. Only the entry-point mechanism changes. This means:

- Templates in `.overkill/` are maintained once
- New platform support is a single-file addition
- Project memory, identity, and verification work identically everywhere
- The global brain (`~/.overkill/`) is shared across all platforms on the same machine
