# Architecture -- OverkillOS

## Two-Tier Memory

OverkillOS operates across two physical locations:

### Global Brain (`~/.overkill/`)

Lives in your home directory, outside any project repo. Persists across ALL projects.

| File | Purpose |
|------|---------|
| IDENTITY.md | Agent name, persona, vibe |
| USER.md | Your profile: preferences, goals, communication style |
| SOUL-BASE.md | Base personality (per-project SOUL inherits from this) |
| LEARNINGS.md | Cross-project lessons (legacy; cascade supersedes) |
| memory/QUICKSTART.md | **Tier 1 global** (~300 tokens): cross-project state, read at every boot |
| memory/MEMORY.md | **Tier 2 global** (~2-5k tokens): how user works, business context, patterns |
| memory/ARCHIVE.md | **Tier 3 global** (unlimited, never pruned): full cross-project history |
| projects/registry.md | Index of every project the agent has worked on |
| projects/\*/summary.md | Condensed snapshot per project |

The global memory cascade ensures the agent carries rich context across projects -- not just bullet-point learnings, but the full depth of how the user thinks, communicates, makes decisions, and what they value in practice.

Created once by `init.sh`. Not committed to git. Optionally backed up to a private repo.

### Per-Project Engine (`.overkill/`)

Lives inside each project repo. Committed to git.

| Directory | Purpose |
|-----------|---------|
| identity/ | BOOTSTRAP.md, SOUL.md, USER.md, TOOLS.md, IDENTITY.md |
| memory/ | QUICKSTART.md (Tier 1), MEMORY.md (Tier 2), ARCHIVE.md (Tier 3), SYNC-PROTOCOL.md |
| orchestration/ | ROLES.md, OPERATOR-DIRECTIVES.md, HANDOFF-TEMPLATE.md, HEARTBEAT.md |
| execution-agent/ | Worker agent scope: AGENTS.md, HANDOFF.md, MEMORY.md |
| verification/ | PLAN-TEMPLATE.md, GATE-DEFINITIONS.md, EVIDENCE-ROW.md |
| prd/ | WORKFLOW.md, project-workflow.md, PRD templates |
| protocols/ | SESSION-BOOT.md, SCOPE-FREEZE.md, ESCALATION.md |

---

## Cursor Auto-Boot Layer

The mechanism that makes OverkillOS work without user intervention:

### AGENTS.md (auto-loaded by Cursor)

Cursor automatically loads `AGENTS.md` from the repository root into every conversation. The OverkillOS `AGENTS.md` contains:

1. **Live State Block** -- ~150 tokens of instant project context. Updated by agent at session end. Zero file reads needed for basic orientation.

2. **Three-Step Boot Sequence** -- Conditional logic that fires on first message:
   - Step 0: Check if `~/.overkill/` exists (global brain detection)
   - Step 1: Check if `BOOTSTRAP.md` exists (first-run detection)
   - Step 2: Four-file read (SOUL, QUICKSTART, yesterday's log, today's log)

3. **Write Trigger Rules** -- Event-based memory writes embedded in the instructions.

### .cursor/rules/*.mdc (context-specific reinforcement)

Three rule files that reinforce AGENTS.md behavior:
- `overkill-session-boot.mdc` -- always active, boot sequence backup
- `overkill-memory-protocol.mdc` -- triggers on `.overkill/` file access
- `overkill-verification-gates.mdc` -- triggers during plan/verification work

---

## Three-Tier Memory Cascade (two instances)

The cascade exists at TWO levels: global and per-project.

### Global Cascade (`~/.overkill/memory/`)
Carries cross-project context. Read at boot in every project.

```
     ~/.overkill/memory/QUICKSTART.md (~300 tokens, every boot Step 0)
         |
         | references
         v
     ~/.overkill/memory/MEMORY.md (~2-5k tokens, on demand)
         |   How user works, business context, decision patterns,
         |   communication style, workflow patterns that transfer
         |
         | references
         v
     ~/.overkill/memory/ARCHIVE.md (unlimited, never pruned)
         Full user profile depth, network, relationship context,
         consolidated cross-project histories, session highlights
```

### Per-Project Cascade (`.overkill/memory/`)
Project-specific context. Read at boot for active project.

```
     AGENTS.md Live State Block (~150 tokens, auto-injected)
         |
         v
     .overkill/memory/QUICKSTART.md (~300 tokens, every boot Step 2)
         |
         | references
         v
     .overkill/memory/MEMORY.md (~2-5k tokens, on demand)
         |
         | references
         v
     .overkill/memory/ARCHIVE.md (unlimited, never pruned)
```

Content flows downward through demotion at both levels. Nothing is deleted. Both ARCHIVEs grow forever.

---

## Bootstrap Flow

```
User types anything
        |
        v
AGENTS.md loaded by Cursor (Live State Block visible)
        |
        v
Step 0: ~/.overkill/ exists? ----NO----> first-ever session
        |                                       |
       YES                                      v
        |                              Step 1: BOOTSTRAP.md exists?
        v                                       |
Step 1: BOOTSTRAP.md exists?              YES: Fork A (first-ever)
        |          |                      Full identity negotiation
       YES        NO                      Create ~/.overkill/
        |          |                      Continue to Phase 2
        v          v
Fork B           Fork C
(returning,      (returning,
new project)     known project)
Skip identity    Normal 4-file boot
Run audit        Respond
```

---

## Role Hierarchy

```
Orchestrator (Human)
    |
    | sets direction, approves
    v
Operator (Primary AI)
    |
    | dispatches scoped tasks
    v
Execution Agent (Worker AI)
    |
    | reports results
    v
Operator reviews, integrates
```

Execution agents never access main memory. The operator never claims orchestrator authority.
