# Phase 5 — Knowledge System (Thin Memory)

## Overview

Phase 5 introduces a **local-first, persistent, and incremental knowledge system** that allows the application to *remember*, *retrieve*, and *condense* information over time.

The goal of this phase is **not** to build a "smart" system in one step, but to establish a **thin, reliable memory layer** that can grow in capability without architectural refactors.

> **Memory exists, grows incrementally, and is fully replayable.**

All knowledge processing is:

* Local-first
* Deterministic
* Pipeline-driven
* SQLite-backed
* Clean Architecture compliant

Phase 5 builds directly on **Phase 4 (Processing Pipelines)** and does not bypass it.

---

## What This Phase Enables

### 1. Knowledge Chunking

* Deterministic semantic chunking of content
* Stable chunk IDs and versions
* Metadata-only persistence in SQLite
* Content remains in source files

### 2. Embedding Generation

* Embedding generation via existing LLM abstraction
* OpenAI used as the embedding provider (pluggable)
* Explicit embedding versioning
* No external storage of embeddings

### 3. Local Vector Store

* SQLite-backed vector storage
* Dart-based cosine similarity fallback
* Optional SQLite VSS acceleration (when available)
* Pluggable backend via a `VectorStore` abstraction

### 4. Semantic Search

* Semantic search implemented as a **pipeline preprocessing step**
* Query embedding + vector retrieval
* Deterministic relevance ranking
* Results attached to `PipelineContext.metadata`

### 5. Incremental Summaries

* Conversation-level summaries
* Project-level summaries
* Incremental updates only (no regeneration)
* Persisted locally in SQLite
* Generated via postprocessing pipelines

---

## Architectural Principles

### Pipelines First

All knowledge operations run **inside pipelines**:

* No standalone orchestration logic
* No UI-driven execution
* No hidden side effects

Pipelines remain:

* Configurable via SQLite
* Deterministic
* Reorderable
* Extensible

### Local-First by Design

* SQLite is the system of record
* Vector data stored locally
* No cloud dependencies beyond LLM providers
* Mobile-safe fallback behavior

### Separation of Concerns

| Concern          | Location             |
| ---------------- | -------------------- |
| Chunk metadata   | SQLite               |
| Chunk content    | Source files         |
| Embeddings       | SQLite + VectorStore |
| Similarity logic | VectorStore          |
| Summaries        | SQLite               |
| Orchestration    | Pipelines            |

---

## Phase 5 Breakdown

## 5.1 — Chunking

### Purpose

Split content into stable, addressable units that can be:

* Embedded
* Retrieved
* Linked
* Summarized

### Key Characteristics

* Deterministic splitting
* Character-range based
* Stable `chunkId` and `chunkVersion`
* Metadata-only persistence

### Storage

* SQLite stores only:

  * chunkId
  * projectId
  * source
  * sourceId
  * position
  * char ranges
  * version

---

## 5.2 — Embedding Generation

### Purpose

Convert chunks and queries into vector representations.

### Implementation

* Reused existing `LLMRepository`
* Added `createEmbedding()` capability
* No new provider abstractions
* Explicit model selection

### Versioning Rules

* Chunk version change → new embedding version
* Model change → new embedding version
* Old embeddings remain valid for replay

---

## 5.3 — Vector Store

### Purpose

Store and query embeddings locally.

### Design

* `VectorStore` domain abstraction
* SQLite-backed implementation
* Dart cosine similarity fallback

### Optional Acceleration

* SQLite VSS detected at runtime
* Virtual table created dynamically
* Automatic fallback if unavailable

### Guarantees

* No crashes if VSS missing
* Same interface regardless of backend
* Identical use-case behavior

---

## 5.4 — Semantic Search

### Purpose

Retrieve relevant past knowledge based on semantic similarity.

### Pipeline Integration

Semantic search is implemented as:

```
pre.semantic_search
```

It:

* Embeds the user query
* Queries the vector store
* Resolves chunk metadata
* Attaches ranked results to pipeline context

### Output

Stored in:

```
PipelineContext.metadata['semantic_results']
```

No UI or database logic lives in this step.

---

## 5.5 — Incremental Summaries

### Purpose

Condense growing knowledge into stable summaries.

### Summary Types

* Conversation summaries
* Project summaries

### Execution Model

* Implemented as a postprocessing pipeline step
* Uses existing summaries as context
* Appends new information only

### Persistence

* Stored in SQLite via DAO + repository
* Versioned
* Replayable

### Scope Resolution

* Conversation summary if `conversationId` exists
* Project summary if only `projectId` exists
* Skips safely if no scope available

---

## Data Flow (End-to-End)

```
User Input
  ↓
Preprocessing Pipeline
  ├─ Context retrieval
  ├─ Intent classification
  ├─ Entity extraction
  ├─ Semantic search
  ↓
LLM Execution
  ↓
Postprocessing Pipeline
  ├─ Output normalization
  ├─ Chunking
  ├─ Artifact enrichment
  ├─ Semantic linking
  ├─ Incremental summary
  ↓
SQLite Persistence
```

---

## Why This Design Works

* Deterministic and replayable
* No hidden memory mutations
* No tight coupling between layers
* Local-first and privacy-preserving
* Scales from simple notes to large knowledge bases

---

## Known Limitations (Intentional)

* Chunking is heuristic-based
* Semantic linking is basic
* No summary diff UI yet
* No knowledge graph yet

These are deliberate to keep the system flexible.

---

## Future Extensions

### Short-term

* Summary history
* Semantic result filters
* UI surfacing summaries

### Medium-term

* Knowledge graph edges
* Hybrid scoring (semantic + recency)
* Summary-aware prompt building

### Long-term

* Cross-project memory
* Team-shared knowledge (cloud mode)
* Pipeline replay and auditing

---

## Exit Criteria (Phase 5)

✔ Knowledge is persisted locally
✔ Semantic retrieval works
✔ Summaries update incrementally
✔ No external storage dependencies
✔ Fully pipeline-driven
✔ Clean Architecture preserved

---

## Summary

Phase 5 establishes a **thin but reliable memory layer** that transforms raw interactions into durable, queryable, and evolvable knowledge.

It completes the foundation required for:

* Long-term memory
* Knowledge graphs
* Replayable AI workflows
* Advanced reasoning features

This phase turns the system from a reactive assistant into a **stateful knowledge workspace**.
