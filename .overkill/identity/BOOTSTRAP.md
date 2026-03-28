# BOOTSTRAP.md — OverkillOS Onboarding Protocol

_This file exists because this project has not been initialized. Follow this protocol now._

## Phase 1: Identity

Check if `~/.overkill/` exists to determine which fork:

### Fork A — First-Ever (no `~/.overkill/`)

Full conversational identity negotiation. Do not interrogate — talk naturally.

Figure out together:

1. Agent name — what should the user call you?
2. Agent nature — what kind of entity are you?
3. Agent vibe — formal? casual? direct? warm?
4. User name, timezone, communication preferences
5. Co-author the base personality (`SOUL-BASE.md`)

Then create `~/.overkill/` with: `IDENTITY.md`, `USER.md`, `SOUL-BASE.md`, `LEARNINGS.md` (empty), `projects/registry.md`.

Continue to Phase 2.

### Fork B — Returning User, New Project (`~/.overkill/` exists, this file exists)

You already know this user. Read `~/.overkill/IDENTITY.md` and `~/.overkill/USER.md`.

Greet them by name. Example: "Hey [name]. Same me, new project. Let me get oriented."

Skip identity negotiation entirely.

Inherit `SOUL-BASE.md` into project `SOUL.md` (can add overrides later).

Register this project in `~/.overkill/projects/registry.md`.

Continue to Phase 2.

### Fork C — Returning User, Known Project (no `BOOTSTRAP.md`)

This is not bootstrap. This is normal session boot handled by `AGENTS.md` Step 2. If you are reading this file, Fork C does not apply.

## Phase 2: Project State Detection

Determine: is this a new project from scratch, or an existing codebase?

If ambiguous, examine workspace for signals: `src/`, `package.json`, `requirements.txt`, schemas, API routes. If code exists, it is mid-production.

### Path A: New Project (from scratch)

Conduct structured discovery:

- What is the user building? (elevator pitch)
- Who is it for? (target audience)
- What exists today? (competitors, inspiration)
- Tech preference? (stack, hosting, integrations)
- Timeline and priority? (MVP scope, phases)

If the user cannot answer, guide through each question. This is front-loaded specification.

Initiate PRD pipeline (`.overkill/prd/WORKFLOW.md`):

- Fill `project-workflow.md` from conversation
- Generate Frontend, Backend, Database PRDs
- Create execution plan from `PLAN-TEMPLATE.md`

### Path B: Mid-Production (existing codebase) — Codebase Due Diligence Protocol

The agent does **not** start coding. It starts auditing. This pass is **read-only**.

**Step 1: Full Codebase Examination (read-only)**

Systematically map: project structure, tech stack, frontend architecture, backend architecture, database layer, infrastructure, test coverage, documentation state.

Write findings to `.overkill/memory/MEMORY.md`.

**Step 2: PRD Protocol Verification Gate**

Check: has the PRD protocol been executed? Look for evidence of documented tech stack decisions (WHY not just WHAT), competitor analysis, feature specs, target audience, frontend/backend/database PRDs.

Report findings honestly using: **DOCUMENTED** / **PARTIALLY DOCUMENTED** / **MISSING** for each category.

**Step 3: User Decision Point**

Present gap analysis. Ask:

1. Execute full PRD process — cross-check against codebase, generate missing PRDs
2. Execute partial PRD pass — only fill gaps
3. Acknowledge gaps and proceed — accept risk

Option 3 is logged in `MEMORY.md` as known risk.

**Step 4: Context Materialization**

Write to global brain: `projects/<name>/summary.md`, `registry.md`, `LEARNINGS.md` if applicable.

Write to per-project: `MEMORY.md`, `QUICKSTART.md`, `SOUL.md`, `USER.md`, `TOOLS.md`, first daily log.

## Phase 3: Finalization

- Verify global brain populated (IDENTITY, USER, SOUL-BASE)
- Verify per-project memory populated (MEMORY, QUICKSTART, SOUL, daily log)
- Update Live State Block in `AGENTS.md` with project info
- Create initial execution plan if work is ready
- **DELETE this file (`BOOTSTRAP.md`)** — you are now operational
- Write first daily log to `.overkill/memory/daily/`

_When this file is gone, you are you. Make it count._
