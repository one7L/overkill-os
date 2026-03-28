# Project Workflow: Four-Pillar Intake

Copy this file per project or major initiative. Replace bracketed guidance with project-specific content. This intake feeds `WORKFLOW.md` and the Frontend, Backend, and Database PRD templates.

---

## Section 1: Tech Stack

Document the technical foundation so PRDs and verification plans stay grounded.

**Fill in:**

- **Frontend:** Framework, language, styling approach, key libraries, browser or client targets.
- **Backend:** Runtime, framework, language, deployment unit (monolith, services), primary patterns (REST, RPC, events).
- **Database:** Engine(s), hosting, ORM or access layer, caching if any.
- **Hosting:** Cloud provider, regions, CI/CD touchpoints, environments (dev/staging/prod).
- **APIs:** Internal vs external boundaries, versioning strategy, documentation expectations.
- **Auth:** Identity provider, session vs token model, roles and tenancy model at a high level.
- **Third-party services:** Billing, email, analytics, maps, ML, etc., with vendor names.

_Placeholder: List unknowns explicitly (e.g., "Auth TBD: Clerk vs custom") so research can target them._

---

## Section 2: Competitor Features

**Fill in for each of 3–5 top competitors:**

- **Name / product** and **segment** (who they sell to).
- **What they do well** (specific capabilities, UX, distribution, pricing).
- **What they lack** (gaps relevant to your audience).
- **Differentiation opportunity** (what you will emphasize or build that they do not).

_Placeholder: If competitors are unclear, name adjacent tools and state why they are partial analogs._

---

## Section 3: Features

**MVP core features** -- For each feature, provide:

- **Name** and **user story** (As a [role], I want [capability], so that [outcome]).
- **Acceptance criteria** (testable bullets).
- **Complexity rating** (e.g., S/M/L or 1–5) and dependencies (other features, data, integrations).

_Placeholder: Mark out-of-MVP ideas in a separate "Later" list to protect scope._

---

## Section 4: Target Audience

**Fill in:**

- **Primary persona:** Role, context, technical literacy, buying behavior.
- **Secondary segments:** Additional personas with different needs or constraints.
- **Pain points:** Concrete problems your product addresses (ranked if possible).
- **Success metrics:** How you will know the product works for them (activation, retention, revenue, task completion, NPS, etc.).

_Placeholder: "Success metrics TBD" is acceptable only with a dated plan to define them._

---

## Document Control

- **Owner:**
- **Last updated:**
- **Status:** Draft | Intake complete | Research in progress | PRDs approved
