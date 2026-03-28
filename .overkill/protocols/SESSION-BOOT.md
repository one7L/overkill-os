# Session Boot Protocol

Read the following at the start of every working session so context, intent, and live state stay aligned. This mirrors **AGENTS.md Step 2** in standalone form for operators and agents.

## Required Reads (in order)

1. **SOUL.md** -- Values, voice, and non-negotiables for how work is done.
2. **QUICKSTART.md** -- Current commands, env setup, and where to run things.
3. **Yesterday's daily log** -- What was attempted, blocked, or shipped.
4. **Today's daily log** -- If it already exists, append; otherwise create it at session start with date and intent.

## Drift Check

After reading **QUICKSTART.md**, compare it to the **Live State Block** (or equivalent "current truth" section in repo docs).

- If commands, ports, env vars, or default branches disagree, **fix QUICKSTART or the Live State Block** so they match reality, or record the discrepancy in today's log with an owner.
- Do not proceed on stale setup assumptions when drift is known.

## Session End

Close the loop by updating today's log with outcomes, blockers, and pointers to evidence or PRs.
