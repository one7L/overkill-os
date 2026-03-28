# Artifact Contract ("No Artifact, No Claim")

## Rule

If you claim that something works, behaves correctly, or meets a bar, you must point to a **concrete artifact**: test output, log excerpt, metric snapshot, screenshot, generated file, or other inspectable output stored at a stable path.

## What Is Not Evidence

Narrative claims without pointers ("I tested it and it works," "should be fine," "looks good") are **not** evidence. They cannot close a gate or satisfy the artifact contract.

## Completion Claims

Every completion claim must:

1. State what is claimed (aligned to a gate or acceptance criterion).
2. Reference a **specific file path** or captured output that an independent reviewer can open or reproduce from documented steps.

If the artifact does not exist or cannot be found, the claim is **invalid** until corrected.

## Canonical Format

Evidence rows (see `EVIDENCE-ROW.md`) are the canonical format for tying claims to artifacts. Use them for gate-supported assertions.

## Reproducibility

Where feasible, artifacts should be reproducible (command + commit hash + environment notes). When reproduction is expensive, the artifact path and method of capture must still be explicit.
