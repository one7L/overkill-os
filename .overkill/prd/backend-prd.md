# Backend PRD: [Product / Initiative Name]

## Overview

**Summary:** [One paragraph: services provided, boundaries, and consumers (web, mobile, workers).]

**Goals:** [Reliability, security, time-to-ship, or domain outcomes.]

**Non-goals:** [Features or stacks explicitly out of scope.]

**Related docs:** [OpenAPI/GraphQL schema location, `database-prd.md`, runbooks.]

---

## Tech Stack

[Runtime, framework, language, package layout, observability stack, config management.]

---

## API Endpoints (RESTful or GraphQL)

| Method / operation | Path or field | Purpose | Auth | Idempotency |
|--------------------|---------------|---------|------|-------------|
| | | | | |

[Versioning, pagination, filtering conventions, deprecation policy.]

---

## Authentication / Authorization

[How identity is established, token or session validation, RBAC or ABAC model, service-to-service auth.]

---

## Business Logic

[Core domain rules, workflows, invariants, side effects. Keep aligned with Frontend PRD user journeys.]

---

## Data Validation

[Input schemas, sanitization, file size and type limits, canonical error shapes for validation failures.]

---

## Error Handling

[HTTP status or error code mapping, retry guidance for clients, logging and redaction rules.]

---

## Rate Limiting

[Limits per identity or IP, burst behavior, headers, escalation when limits hit product surfaces.]

---

## Third-Party Integrations

[External APIs, webhooks sent and received, secrets handling, failure modes and fallbacks.]

---

## Background Jobs / Queues

[Scheduled tasks, async processors, DLQ strategy, ordering and deduplication expectations.]

---

## Document Control

- **Owner:**
- **Last updated:**
- **Status:** Draft | Review | Approved
