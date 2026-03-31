# OverkillOS

**Current template version: 1.2.0** — see `VERSION` and `CHANGELOG.md`.

A Cursor-first operational environment for AI-assisted software development. Two-tier memory, gate-based verification, role separation, and evidence discipline -- encoded into markdown files that any AI agent can follow.

## What This Is

OverkillOS is a reusable template that gives your AI coding agent persistent memory, structured onboarding, rigorous execution plans, and a research-to-PRD pipeline. Install it into any project and the agent self-initiates on first contact.

It is not a framework, not a library, not a SaaS product. It is a set of markdown files that define how your AI agent operates -- across sessions, across projects, across context windows.

## Architecture

```
~/.overkill/                    Global brain (persists across ALL projects)
  IDENTITY.md                   Agent persona (name, vibe, nature)
  USER.md                       Your profile (preferences, goals, style)
  SOUL-BASE.md                  Base personality constitution
  LEARNINGS.md                  Cross-project lessons
  projects/registry.md          Index of all projects

<your-project>/
  AGENTS.md                     Cursor auto-boot entry point (Live State Block + boot sequence)
  .cursor/rules/*.mdc           Cursor rule reinforcement
  .overkill/                    Per-project engine
    identity/                   BOOTSTRAP.md, SOUL.md, USER.md, TOOLS.md, SESSION-IDENTITY.md (optional)
    hosts/                      Host playbooks: cursor, antigravity, openclaw
    memory/                     QUICKSTART.md (Tier 1), MEMORY.md (Tier 2), ARCHIVE.md (Tier 3)
    orchestration/              ROLES.md, OPERATOR-DIRECTIVES.md, HANDOFF-TEMPLATE.md
    execution-agent/            Worker agent scope (AGENTS.md, HANDOFF.md, MEMORY.md)
    verification/               PLAN-TEMPLATE.md, GATE-DEFINITIONS.md, EVIDENCE-ROW.md
    prd/                        WORKFLOW.md, project-workflow.md, frontend/backend/database PRDs
    protocols/                  SESSION-BOOT.md, SCOPE-FREEZE.md, ESCALATION.md, SDLC-MAP.md (pointer)
  adapters/                     Cursor / Antigravity / OpenClaw notes
  scripts/                      overkill-sync.sh, MANAGED-FILES.txt (template → existing repos)
```

## Quick Start

### Install into a new project

```bash
git clone https://github.com/one7L/overkill-os.git ~/github/overkill-os
cd ~/github/overkill-os
./init.sh ~/github/my-project
```

### Install into an existing project

```bash
./init.sh ~/github/existing-project
```

### What happens next

1. Open the project in Cursor
2. Type anything -- even just "hey"
3. The agent reads `AGENTS.md`, detects `BOOTSTRAP.md`, and self-initiates
4. First time: full identity negotiation, then codebase audit
5. Returning user: agent greets you by name, skips identity, runs audit
6. After bootstrap completes: every future session auto-boots with four file reads

## How It Works

### Live State Block (zero-cost context)

The `AGENTS.md` file contains a Live State Block that Cursor auto-injects into every conversation. The agent updates it at the end of each session. Next session, instant project awareness -- no file reads needed for basic orientation.

### Four-File Boot (on first message)

When you send your first message, the agent reads exactly four files:

1. `SOUL.md` -- project personality and boundaries
2. `QUICKSTART.md` -- project state, ~300 tokens
3. Yesterday's daily log -- what happened last session
4. Today's daily log -- earlier work today (if exists)

Combined with the Live State Block, full contextualization in ~500 tokens.

### Three-Tier Memory Cascade (global + per-project)

The cascade exists at two levels:

**Global (`~/.overkill/memory/`)** -- cross-project context that follows you everywhere:

| Tier | File | Size | When Read |
|------|------|------|-----------|
| 1 | QUICKSTART.md | ~300 tokens | Every boot, every project (Step 0) |
| 2 | MEMORY.md | ~2-5k tokens | On demand |
| 3 | ARCHIVE.md | Unlimited | By section anchor |

Contains: how you work, decision patterns, business context, network, communication style, cross-project lessons.

**Per-project (`.overkill/memory/`)** -- project-specific context:

| Tier | File | Size | When Read |
|------|------|------|-----------|
| 1 | QUICKSTART.md | ~300 tokens | Every boot (Step 2) |
| 2 | MEMORY.md | ~2-5k tokens | On demand |
| 3 | ARCHIVE.md | Unlimited | By section anchor |

Content is demoted down tiers, never deleted. Both ARCHIVEs grow forever.

### Event-Based Write Triggers

The agent writes to memory based on events, not arbitrary intervals:

- After completing any task
- After significant decisions
- Before switching topics
- Every ~15 message exchanges
- At end of session (Live State Block + daily log)

### Bootstrap Protocol (three forks)

- **First-ever**: Full identity negotiation, creates global brain
- **Returning user, new project**: Skips identity, runs codebase audit
- **Returning user, known project**: Normal four-file boot

## Core Principles

1. **Text over Brain** -- write it to a file or it does not exist
2. **No Artifact, No Completion Claim** -- show the evidence
3. **Three-Tier Memory Cascade** -- demotion, never deletion
4. **Role Separation** -- orchestrator (human), operator (AI), execution agent (worker)
5. **Gate Before Advance** -- binary pass/fail, no skipping
6. **No Regression as Policy** -- passing properties stay passing
7. **Evidence Discipline** -- structured rows, not narrative claims
8. **Front-Loaded Specification** -- research and PRDs before code
9. **Due Diligence Before Contribution** -- audit before coding
10. **Proactive Memory Protection** -- checkpoint before context is lost

## Platform Strategy

**Primary: Cursor IDE.** The auto-boot mechanism uses Cursor's `AGENTS.md` + `.cursor/rules/` system.

**Future expansion:** See `docs/ADAPTING.md` for how to port to Claude Code (`CLAUDE.md`), OpenClaw, or generic AI IDEs. The core `.overkill/` files are platform-agnostic markdown.

**Product roadmap:** See `docs/TAURI-PRODUCT-PLAN.md` for the plan to ship OverkillOS as a native desktop application (Tauri + Rust backend + local MCP server). The file-based template is the personal tool; the Tauri app is the commercial product.

## Docs

- `CHANGELOG.md` -- version history (matches `VERSION` and `init.sh`)
- `docs/CURRENT-PLAN.md` -- maintainer anchor for next roadmap iteration
- `docs/OVERKILL-SDLC-MAP.md` -- pillar rigor, integration checkpoints, GTM placement
- `docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md` -- sync template into existing projects
- `docs/CROSS-IDE-ADAPTATION.md` -- Cursor, Antigravity, OpenClaw
- `docs/PHILOSOPHY.md` -- deep dive into the 14 core principles
- `docs/ARCHITECTURE.md` -- layer descriptions and diagrams
- `docs/ADAPTING.md` -- porting to other platforms
- `docs/EXAMPLES.md` -- walkthrough of real-world usage
- `docs/TAURI-PRODUCT-PLAN.md` -- desktop app product plan (Tauri + Rust + MCP)

## License

MIT
