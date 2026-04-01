# Diagnostic Protocol Spec v1

This spec defines the deterministic, stage-machine diagnostic behavior for OverkillOS projects.

## Result classes

- `PASS` — requirement verified by explicit artifact path.
- `WARN` — non-blocking issue; proceed with caution.
- `HARD_FAIL` — blocking requirement missing or invalid.
- `SKIP(reason)` — check not applicable or unverifiable in current mode.

Never report overall green if any `HARD_FAIL` exists.

## Pipeline stage model

1. `Stage0_Intake`
2. `Stage1_CompetitorResearch`
3. `Stage1_TargetAudience`
4. `Stage1_FeatureArchitecture`
5. `Stage1_TechStack`
6. `Stage2_PRDSynthesis`
7. `Stage3_ContractsAndPrep`
8. `Stage4_BuildAndVerify`
9. `Stage5_ReleaseReadiness`
10. `Stage6_GTMReady`

Pre-PRD condition:

`Competitor + TargetAudience + Features + TechStack => PRD synthesis allowed`

## Required output schema (human-readable + machine-friendly)

- `current_stage`
- `next_stage`
- `blockers[]`
- `warnings[]`
- `recommended_department` (`General|DB|BE|FE|GTM`)
- `recommended_ide` (`Cursor|Antigravity|OpenClaw`)
- `next_prompt`

## Minimum deterministic checks

- Required files exist (`AGENTS.md`, `.overkill/*` essentials)
- Session identity + host playbook availability
- Execution boundary policy present (`.overkill/execution-agent/AGENTS.md`)
- PRD workflow artifacts and stage requirements
- Diagnostics logging paths writable

## Runtime modes

- Default: fast deterministic checks
- `--full`: deeper scan for higher confidence; still deterministic

## Logging

- Detailed report: `.overkill/logs/diagnostics/<timestamp>.md`
- Index append: `.overkill/logs/DIAGNOSTICS.md`
