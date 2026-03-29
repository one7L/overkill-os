# SYNC-PROTOCOL -- Memory Cascade Rules

> This file defines when and how the agent reads, writes, and demotes memory.
> It is the authoritative reference for all memory operations.

## The Three-Tier Cascade

### Tier 1: QUICKSTART.md (~300-500 tokens, read at every boot)
One-liner summaries. References Tier 2 for detail.
Example: "Auth: Supabase. See MEMORY.md #auth-decisions for rationale."

### Tier 2: MEMORY.md (~2,000-5,000 tokens, read on demand)
Curated working memory. Decisions, architecture, active state.
References Tier 3 for full history.
Example: "## auth-decisions\nMigrated from Better-Auth to Supabase 2026-03-15.\nSee ARCHIVE.md #auth-migration-full for complete log."

### Tier 3: ARCHIVE.md (unlimited, NEVER pruned, read by section anchor)
Permanent record. Full decision logs, migration histories, resolved issues.
Example: "## auth-migration-full\n[Full 2000-word account...]"

## Demotion Rules

- When QUICKSTART exceeds ~500 tokens: move detail to MEMORY.md, leave one-liner + reference
- When MEMORY.md exceeds ~5,000 tokens: move resolved/historical sections to ARCHIVE.md, leave summary + reference
- ARCHIVE.md is NEVER pruned. It grows forever.
- Content demotion happens during checkpoint writes, not as a separate task.

## Event-Based Write Triggers

### Daily Log (.overkill/memory/daily/YYYY-MM-DD.md)

| Trigger | What to Write |
|---------|---------------|
| After completing any task or subtask | What was done, outcome, artifact paths |
| After any significant decision | Decision, rationale, alternatives considered |
| Before switching topics or features | Summary of current topic state |
| When user changes subject | Checkpoint of where things stand |
| Every ~15 message exchanges | Running summary since last write |
| Before starting complex multi-step task | Current state snapshot for recovery |
| At end of session | Session summary: accomplished, blockers, next action |

### QUICKSTART.md
- When project status changes (blocker resolved, new blocker, milestone)
- When a non-negotiable or guardrail changes
- When validation order changes
- Always keep in sync with Live State Block in AGENTS.md

### MEMORY.md
- When architecture decisions are made or changed
- When new failure modes discovered
- When PRD status changes
- When significant technical debt identified
- At end of major work phases

### ARCHIVE.md
- When content demoted from MEMORY.md
- Weekly: consolidate daily logs (summarize week, archive raw details)
- When major phase or milestone completes (full retrospective)

### AGENTS.md Live State Block
- At END of every session (last action before conversation ends)
- When a blocker is resolved or new one appears
- When project status materially changes

### Execution-Agent Memory
- Only when worker-relevant state changes

## Global Brain Sync

The global brain has its own three-tier memory cascade at `~/.overkill/memory/`.
This carries cross-project context so every new project starts with full awareness.

### ~/.overkill/memory/QUICKSTART.md (Tier 1 global, ~300 tokens)
Read at every boot in every project (Step 0).
Update when:
- User's cross-project priorities change
- A new "never-again" rule is discovered
- Active workstreams change
- Communication/work pattern insights are confirmed across multiple sessions

### ~/.overkill/memory/MEMORY.md (Tier 2 global, ~2-5k tokens)
Read on demand when cross-project depth is needed.
Update when:
- New workflow patterns are confirmed (how the user approaches problems, scopes work, escalates)
- Business context changes (new clients, revenue shifts, company updates)
- Architecture or debugging patterns transfer across projects
- User pushback patterns or decision-making styles are observed and documented

### ~/.overkill/memory/ARCHIVE.md (Tier 3 global, unlimited, NEVER pruned)
Read by section anchor only.
Update when:
- Content demoted from global MEMORY.md
- A project milestone generates cross-project lessons
- User relationship/network/business details need full-depth storage
- Session histories with cross-project significance are consolidated

### ~/.overkill/LEARNINGS.md
Legacy file. Still valid. Contains bullet-point lessons.
New learnings should go to the global memory cascade instead.
Existing content remains as reference.

### ~/.overkill/USER.md
Update when user preferences change.

### ~/.overkill/projects/<name>/summary.md
Update at end of significant work sessions, milestones, status changes.

### ~/.overkill/projects/registry.md
Update when project status changes.

### NEVER update without explicit user approval:
- ~/.overkill/IDENTITY.md (agent core identity)
- ~/.overkill/SOUL-BASE.md (behavioral constitution)

## Drift Detection (at session start)

Before responding to the first message:
1. Verify QUICKSTART.md status lines match Live State Block in AGENTS.md
2. Verify today's daily log (if exists) has most recent timestamps
3. If drift detected: reconcile silently (update stale file), note in daily log
