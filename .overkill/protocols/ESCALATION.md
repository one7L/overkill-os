# Escalation Protocol

Use this format when the operator cannot resolve a blocker within the current plan, authority, or time box. The orchestrator makes the final call; the operator supplies clarity and options.

## When to Escalate

Escalate when any of the following apply:

- A **gate fails repeatedly** after targeted fixes (flaky or systemic).
- An **architectural conflict** is discovered (PRDs, schema, or security contradict implementation reality).
- An **external dependency** blocks progress (vendor outage, legal, access, third-party API).
- **Scope** must change to proceed (new requirement, retired guarantee, discovered essential work).

## Escalation Format

Use this template verbatim in the daily log, chat, or ticket:

```text
ESCALATION: [topic]

Current state: [X]

Blocker: [Y]

Options:
A) [description] -- [tradeoffs]
B) [description] -- [tradeoffs]
C) [description] -- [tradeoffs]

Recommendation: [preferred option and why]
```

Adjust the number of options as needed; keep at least two when a real choice exists.

## Authority

- The **orchestrator** decides among options, approves scope or plan changes, and may request more evidence.
- The **operator** presents options with tradeoffs and does **not** decide on escalated items alone.

## Follow-Up

After resolution, record the decision, owner, and any updates to PRDs, plans, or gates. If the resolution changes pass criteria, add an evidence row and update gate definitions in the plan of record.
