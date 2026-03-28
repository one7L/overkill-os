# Examples -- OverkillOS in Practice

## Example 1: New SaaS Project from Scratch

### Setup

```bash
mkdir ~/github/my-saas
cd ~/github/overkill-os
./init.sh ~/github/my-saas
```

### First Session

```
User: hey

Agent: Hey. I just came online and I can see this is our first session
together -- I found my bootstrap protocol. Before we dive into anything,
let me get set up properly so I can actually help you.

First, let's figure out who I am to you. What should you call me?

User: Call yourself Rig. Be direct, no-nonsense, technically sharp.

Agent: Rig. Got it. Direct, technically sharp, no fluff. I like it.

What's your name? And how do you like to work -- do you prefer I ask
before doing things, or should I take initiative and just tell you what
I did?

[...identity negotiation continues...]
[...BOOTSTRAP.md Phase 1 completes, ~/.overkill/ created...]

Agent: Now I need to understand what we're building. This workspace is
empty, so we're starting from scratch. Let me walk through the discovery:

1. What are you building? Give me the elevator pitch.
2. Who is it for?
3. What already exists in this space?
4. Tech preferences?
5. Timeline?

User: It's a project management tool for construction crews. Small teams,
5-20 people. Nothing out there handles both scheduling and material tracking.
Next.js, Supabase, Vercel. MVP in 6 weeks.

Agent: Clear. Let me populate the four-pillar workflow and generate PRDs.

[...PRD pipeline executes...]
[...MEMORY.md, QUICKSTART.md, SOUL.md populated...]
[...BOOTSTRAP.md deleted...]
[...Daily log written...]
```

### Second Session (next day)

```
User: morning

Agent: Morning. Yesterday we generated the three PRDs for the construction
PM tool. Frontend PRD covers 12 routes, backend has 23 API endpoints,
database schema has 8 tables. You approved all three.

Current status: ready to begin Phase 1 (auth + database setup) from
the execution plan. Want to start?
```

The agent knew all of this from the Live State Block (auto-injected) and the four-file boot (SOUL, QUICKSTART, yesterday's log, today's log).

---

## Example 2: Joining an Existing Codebase Mid-Production

### Setup

```bash
cd ~/github/overkill-os
./init.sh ~/github/existing-project
```

### First Session (returning user)

```
User: hey

Agent: Hey Luiz. Same me, new project. I see we've worked on 3 projects
together. Let me get oriented on this one.

I can see code in the workspace -- this is an existing codebase. Let me
run my due diligence audit before we do anything.

[...reads project structure, package.json, routes, schema...]

Here is what I found:

- Project: existing-project (Next.js 14 / Prisma / PostgreSQL / Vercel)
- Frontend: 24 components, App Router, Tailwind
- Backend: 15 API routes, auth via NextAuth
- Database: 12 tables, 3 pending migrations
- Tests: 8 test files, ~40% coverage
- Docs: README exists, no PRDs

PRD Protocol Verification:
- Tech Stack: PARTIALLY DOCUMENTED (package.json, no rationale)
- Competitor Analysis: MISSING
- Feature Specifications: MISSING
- Target Audience: MISSING
- Frontend PRD: MISSING
- Backend PRD: MISSING
- Database PRD: MISSING

The OverkillOS protocol requires front-loaded specification. I found
significant gaps. Would you like me to:

1. Execute full PRD process
2. Partial pass -- only fill gaps
3. Acknowledge gaps and proceed

User: Option 2. Fill what's missing but don't redo what we already have.

Agent: Starting partial PRD pass. I'll generate specs that describe the
existing system accurately, then flag what's undocumented...
```

---

## Example 3: Execution Plan with Gates

After PRDs are complete, the agent creates an execution plan using PLAN-TEMPLATE.md:

```markdown
# Construction PM -- Phase 1 Execution Plan

## Single Execution Order
Phase0 (schema) -> Gate0 (migrations pass) -> Phase1 (auth) ->
Gate1 (login flows verified) -> Phase2 (CRUD) -> Gate2 (all endpoints tested)

## Gate 0 -- Schema Migration
- Pass criteria: all migrations run without error, schema matches PRD
- Evidence: migration log output, schema diff against database-prd.md

## Gate 1 -- Auth Flows
- Pass criteria: signup, login, logout, password reset all work end-to-end
- Evidence: test output for each flow, session token verification

## Gate 2 -- CRUD Endpoints
- Pass criteria: all 23 API endpoints return correct responses
- No regression: Gate 0 and Gate 1 still passing
- Evidence: test suite output, no failing tests
```

The agent enforces these gates. It will not start Phase 2 until Gate 1 passes. If Gate 0 regresses during Phase 1 work, it stops and fixes the regression before proceeding.

---

## Example 4: Memory Demotion in Action

After several weeks of work, QUICKSTART.md is getting long:

```
Before demotion (QUICKSTART.md at ~600 tokens):

## Architecture Decisions
- Auth: Supabase (migrated from NextAuth 2026-04-01)
- Reason: RLS, built-in user management, simpler session handling
- Migration involved: removing 3 NextAuth files, updating 12 API routes...

After demotion (QUICKSTART.md back to ~350 tokens):

## Architecture Decisions
- Auth: Supabase. See MEMORY.md #auth-migration for details.
```

The full migration story moved to MEMORY.md under `## auth-migration`. If MEMORY.md later exceeds ~5,000 tokens, the resolved migration history moves to ARCHIVE.md under `## auth-migration-full`, and MEMORY.md keeps a one-liner reference.

Nothing is lost. Ever.
