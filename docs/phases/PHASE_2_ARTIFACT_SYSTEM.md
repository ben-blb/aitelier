# Phase 2 — Artifact System (Spine)

## Overview

Phase 2 introduces the **Artifact System**, the foundational spine of Aitelier.  
Artifacts are persistent, project-scoped knowledge units that ensure **no LLM output is ever lost**, and that all knowledge remains **traceable, queryable, and explainable** over time.

This phase establishes:
- A canonical artifact model
- Deterministic filesystem storage
- Guaranteed capture of all outputs
- Indexing and lookup APIs
- Provenance and lineage tracking
- A minimal but functional viewing UI

Artifacts are **offline-first**, **Git-friendly**, and **project-isolated** by design.

---

## Phase Goals

- Every LLM output becomes an artifact
- Artifacts are immutable and versioned
- Artifacts are scoped per project
- Artifacts are discoverable without loading content
- Artifacts are explainable (origin, purpose, lineage)
- UI can browse and inspect artifacts safely

---

## Phase Breakdown

### 2.1 — Artifact Core Model

#### Purpose
Define the **canonical domain model** for artifacts without any persistence or UI concerns.

#### Key Decisions
- Artifacts are immutable by default
- New knowledge creates new versions
- Identity uses ULID
- Provenance is mandatory
- Domain layer has no storage logic

#### Core Fields
- `id` (ULID)
- `type`
- `title`
- `tags`
- `version`
- `timestamps`
- `origin` (conversation, purpose, parent)
- `isGeneric`

Artifacts may exist without content (important for processors).

---

### 2.2 — Artifact Storage (Infrastructure)

#### Purpose
Persist artifacts deterministically on disk in a **Git-safe**, **human-readable** format.

#### Final Directory Structure (Project-Scoped)

```text
<workspace_root>/
└── <projectId>/
    └── artifacts/
        ├── index.json
        ├── conversations/
        ├── provenance/
        └── <artifact-id>/
            ├── metadata.json
            ├── versions.json
            └── content/
                └── vX.Y.Z/
                    └── artifact.*
````

#### Key Rules

* Metadata and content are separated
* Versions are folder-based
* Indexes are derived data
* Storage is project-scoped (critical fix)

#### Services Implemented

* `ArtifactFileWriter`
* `ArtifactFileReader`
* `ArtifactIndexService`
* `ConversationIndexService`
* `ArtifactStorageService`

All services live in the **infrastructure layer** and are wired via Riverpod providers.

---

### 2.3 — Generic Artifact Processor (MANDATORY)

#### Purpose

Guarantee that **every LLM output is persisted**, even if no specialized processor exists.

#### Guarantees

* No output is ever dropped
* Raw output is always stored
* Generic fallback artifacts always exist
* Failures never silently discard data

#### Behavior

* Generates artifact ID (ULID)
* Builds minimal metadata
* Stores raw output as content
* Links artifact to conversation and purpose

This processor is **always-on** and acts as the system’s safety net.

---

### 2.4 — Artifact Indexing & Lookup

#### Purpose

Make artifacts **cheap to list**, **fast to query**, and **UI-friendly** without loading content.

#### Indexes

* Global project artifact index
* Conversation → artifact index
* Tag and type filtering
* Lookup by conversation

#### DTO

* `ArtifactSummary` (read-only, lightweight)

#### Lookup API

* `ArtifactLookupService`

  * `listAll(projectId)`
  * `findByConversation(projectId, conversationId)`
  * `findByTag(projectId, tag)`
  * `findByType(projectId, type)`

Indexes are **derived and rebuildable**.

---

### 2.5 — Artifact Provenance

#### Purpose

Make artifacts **explainable** and **navigable as knowledge**, not just files.

#### Provenance Capabilities

* Artifact → Conversation
* Artifact → Purpose
* Artifact → Parent / Children (lineage)

#### Provenance Storage

```text
artifacts/
└── provenance/
    ├── artifact_provenance.json
    ├── purposes/
    │   └── <purpose-hash>.json
    └── lineage/
        └── <artifact-id>.json
```

#### Services

* `ArtifactProvenanceService`
* `PurposeIndexService`
* `LineageIndexService`

Provenance is append-only and queryable.

---

### 2.6 — Minimal Artifact Viewing UI

#### Purpose

Validate the entire Artifact System end-to-end with a **tiny, honest UI**.

#### UI Components

* Artifact List View
* Artifact Detail View (raw content)

#### Application Use Cases

* `ListArtifacts`
* `ListArtifactsByConversation`

UI talks **only to use cases**, never directly to infrastructure.

---

## Critical Riverpod Lessons (Hard-Won)

### ❌ What Went Wrong

* Creating `FutureProvider` inside `build()`
* Caused infinite rebuild → loading loops
* Logs appeared endlessly
* UI never resolved

### ✅ Correct Pattern

* Providers are **top-level**
* Use `FutureProvider.family` for parameterized async data
* Use stable key objects for caching

#### Fixed Providers

* `listArtifactsProvider(projectId)`
* `artifactContentProvider(ArtifactContentKey)`

This fix stabilized:

* Artifact list view
* Artifact detail view

---

## Project Scoping Fix (Important Architecture Correction)

### Problem

Artifacts were initially stored under:

```text
<workspace_root>/artifacts/
```

This broke:

* Multi-project isolation
* Provenance correctness
* Git semantics

### Final Correct Rule

> **Artifacts are scoped per project, just like conversations.**

All artifact services were refactored to resolve paths as:

```text
<workspace_root>/<projectId>/artifacts/
```

Providers were updated to use `Provider.family` with `projectId`.

---

## What This Phase Achieved

* ✔ Knowledge persistence is guaranteed
* ✔ Artifacts are immutable and versioned
* ✔ Artifacts are project-isolated
* ✔ Artifacts are queryable without loading content
* ✔ Provenance and lineage are explicit
* ✔ UI can browse artifacts safely
* ✔ Riverpod usage is correct and scalable

---

## What This Phase Explicitly Does NOT Do (Yet)

* Full-text search
* Semantic embeddings
* Ranking or relevance
* Markdown rendering
* Graph visualization
* Cross-project queries

These are **deliberately deferred**.
