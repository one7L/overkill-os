# Overkill SDLC map — pillars, gates, integration, GTM

> **Purpose:** Align multi-pillar PRDs (frontend, backend, database, GTM) with OverkillOS rigor **without** forcing identical gates per pillar. Use this as the reference for specialized IDE workspaces and cross-agent coordination.

**Canonical copies:** **overkill-os** (this file) and **overkillos-origins** `docs/OVERKILL-SDLC-MAP.md`.

---

## 1. SDLC phases (continuous, not waterfall)

| Phase | Intent | OverkillOS expression |
|-------|--------|------------------------|
| Discover / frame | Problem, user, constraints, success metrics | PRD intake, `MEMORY` decisions, evidence rows |
| Design / contract | Architecture, API, schema, threat surface (light) | PRDs + explicit **contracts** (OpenAPI, schema migrations) |
| Build | Implement behind contracts | Scoped work, execution agents, handoffs |
| Verify | Tests, gates, no-regression | `.overkill/verification/`, corpus / CI |
| Ship | Release, flags, rollback story | Deployment checklist, staging parity |
| Operate | SLOs, incidents, feedback loop | Runbooks, postmortems, metrics → PRD updates |
| Grow | GTM, experiments (when product is measurable) | GTM PRD + analytics / experiment discipline |

Phases **overlap**; order is **dependency-aware**, not calendar-rigid.

### Stage-machine diagnostic mapping (v1)

`Stage0_Intake -> Stage1_CompetitorResearch -> Stage1_TargetAudience -> Stage1_FeatureArchitecture -> Stage1_TechStack -> Stage2_PRDSynthesis -> Stage3_ContractsAndPrep -> Stage4_BuildAndVerify -> Stage5_ReleaseReadiness -> Stage6_GTMReady`

Pre-PRD hard gate:

`Competitor + TargetAudience + Features + TechStack => PRD synthesis allowed`

---

## 2. Pillar rigor matrix (same discipline, different artifacts)

Rigor = **evidence + gates appropriate to failure modes**. Not every pillar runs the same checks.

| Pillar | Primary failure modes | Typical gates / artifacts |
|--------|------------------------|---------------------------|
| **Database** | Data loss, bad migration, RLS holes, perf cliffs | Migration review, rollback notes, RLS tests, backup story |
| **Backend / API** | Contract drift, authz bugs, idempotency, abuse | Contract tests, integration tests, rate limits, observability hooks |
| **Frontend** | UX regressions, a11y, perf, wrong API usage | E2E / visual where needed, a11y checks, API consumer alignment |
| **GTM** (fourth pillar) | Wrong positioning, unmeasurable campaigns, brand/legal risk | Hypotheses, channel plan, metrics definitions, creative/claims review, experiment logs |

**Rule:** Do not copy **engineering test** gates onto **GTM** verbatim; use **GTM-appropriate** evidence (metrics exports, experiment protocols, brand rationale docs).

---

## 3. Integration checkpoints (avoid divergent “pillar-perfect” silos)

Use explicit **sync points** when multiple IDE workspaces / agents work in parallel:

1. **Contract first:** API + schema (+ events) agreed or versioned before large parallel FE/BE work.
2. **Integration PR / milestone:** End-to-end path passes (smoke + critical user journey).
3. **Periodic merge cadence:** Short-lived branches or trunk + feature flags to reduce drift.
4. **Single source of truth** for cross-cutting decisions (short RFC or `MEMORY` anchor + link from each pillar PRD).

---

## 4. Cross-cutting areas (often under-specified in PRD-only setups)

| Area | Minimum expectation |
|------|---------------------|
| **Security / privacy** | Authz model, secrets handling, dependency/CVE policy, PII/data retention when relevant |
| **Observability** | Logs/metrics/traces for critical paths before scale |
| **Release** | Staging parity, migration strategy, rollback/kill-switch |
| **Support / feedback** | How production learnings flow back to PRDs |

These are **not** duplicates of the three product PRDs; they **cut across** them.

---

## 5. Where **GTM** plugs in

- **Early:** positioning, ICP, competitive framing, messaging constraints (feeds **product** scope).
- **Parallel:** experiments and channel tests only when **instrumentation** exists (events, funnels).
- **Scale:** paid spend and broad campaigns when **economics and compliance** are understood.

GTM PRD should reference **metrics definitions** and **experiment design**, not only creative output.

---

## 6. Order: does it matter?

**Yes, for dependencies:**

- Clarity on **problem and constraints** before heavy build.
- **Contracts** (API/schema) before unconstrained parallel implementation.
- **Security/privacy** early when they change architecture.
- **Observability / release** before demanding reliability at scale.
- **Broad GTM spend** after the product can support measurement and promises.

**No**, for repeating discovery and iteration—loops are expected.

---

## 7. Related

- `docs/OPERATOR-RUNBOOK-TEMPLATE-SYNC.md` — propagating template updates to live repos.
- `docs/CROSS-IDE-ADAPTATION.md` — Cursor, Antigravity, OpenClaw.
- `.overkill/verification/` — gate definitions in a given project.
- `.overkill/prd/` — pillar PRDs; **gtm-prd** to be added when you execute the fourth pillar.

---

_End of map — expand per product in project `MEMORY.md` when norms are established._
