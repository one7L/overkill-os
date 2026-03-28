# Database PRD: [Product / Initiative Name]

## Overview

**Summary:** [What data the system persists, consistency expectations, and primary access patterns.]

**Goals:** [Integrity, query performance, operational simplicity, compliance drivers.]

**Non-goals:** [Analytics warehouses, archival stores, or engines explicitly excluded.]

**Related docs:** [ER diagrams, migration repo, `backend-prd.md`.]

---

## Database Choice (with Rationale)

**Primary engine:** [e.g., PostgreSQL, MySQL, MongoDB.]

**Rationale:** [Fit to workload, team skill, hosting, extensions, ecosystem.]

**Additional stores:** [Redis, search, object storage] and why they exist.

---

## Schema Design (Tables / Collections)

[Logical model: entities, key columns, enums, soft delete, timestamps. Prefer a table list or reference to migration names.]

---

## Relationships

[One-to-one, one-to-many, many-to-many, foreign key and cascade rules, orphan prevention.]

---

## Indexes

[Query-driven index list, partial indexes, uniqueness constraints, expected churn (write amplification).]

---

## Migrations Strategy

[Tooling, ordering, backward compatibility for zero-downtime deploys, rollback expectations, naming conventions.]

---

## Seed Data

[Required reference data, dev fixtures, anonymized production-like samples, PII rules.]

---

## Backup Strategy

[Frequency, retention, restore testing cadence, RPO/RTO targets, encryption.]

---

## Row-Level Security (if applicable)

[Policies, roles, tenant isolation model, bypass rules for admin or batch jobs, testing approach.]

_If not applicable, state: "Row-level security not used; access enforced in application layer only."_

---

## Document Control

- **Owner:**
- **Last updated:**
- **Status:** Draft | Review | Approved
