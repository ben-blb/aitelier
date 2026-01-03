# Phase 4 — Processing Pipelines

## Overview

Phase 4 introduces a **generic, deterministic, and configurable pipeline system** that allows the application to automatically structure inputs and outputs around conversations and purposes.

The core idea is simple:

> **Pipelines are data. Steps are capabilities. Execution is deterministic.**

This phase lays the foundation for:
- Preprocessing user input
- Postprocessing LLM output
- Attaching behavior to conversation purposes
- Reconfiguring behavior without code changes

All pipelines are **configured via SQLite**, while execution logic lives in code and is resolved at runtime.

---

## What This Phase Enables

### 1. Generic Pipeline Framework
- Pipelines are defined as ordered lists of step IDs
- Steps are resolved dynamically at runtime
- Execution is deterministic and isolated
- Failures do not corrupt global state

### 2. Preprocessing Pipelines (Phase 4.2)
Preprocessing runs **before LLM execution** and enriches the input context.

Currently implemented steps:
- **Context retrieval (mock)**  
  Placeholder for future vector / graph lookup.
- **Intent classification (heuristic)**  
  Detects basic intent such as `debugging`, `architecture`, or `general`.
- **Entity extraction (regex-based)**  
  Extracts lightweight entities (classes, files, tables).

All results are stored in `PipelineContext.metadata`.

---

### 3. Postprocessing Pipelines (Phase 4.3)
Postprocessing runs **after LLM execution** and structures the output.

Currently implemented steps:
- **Output normalization**  
  Canonicalizes whitespace and line breaks.
- **Chunking (mock)**  
  Splits output into basic text chunks.
- **Artifact enrichment**  
  Converts chunks into structured artifact objects.

These steps prepare output for:
- Artifact persistence
- Knowledge ingestion
- UI rendering

---

### 4. Pipeline Configuration (Phase 4.4)

#### SQLite-driven configuration
Pipelines are stored as pure configuration:
- Pipeline ID
- Name
- Enabled flag
- Ordered list of step IDs

No executable logic lives in SQLite.

#### Purpose → Pipeline mapping
Each conversation purpose (e.g. `debugging`, `architecture`) can be mapped to a pipeline.

At runtime:
1. The purpose resolves to a pipeline
2. The pipeline resolves to step handlers
3. Steps execute in order

---

### 5. Runtime Execution Model

The runtime model is strictly layered:

- **Registry (code)**  
  Registers all available step implementations.
- **Repository (SQLite)**  
  Loads pipeline configuration.
- **Resolver**  
  Maps purpose → pipeline.
- **Executor**  
  Executes steps sequentially using `PipelineContext`.

This separation guarantees:
- Determinism
- Extensibility
- Testability
- No hidden behavior

---

### 6. UI Configuration

A minimal UI was added to prove configurability:

- List existing pipelines
- Enable / disable pipelines
- Create pipelines dynamically
- Assign pipelines to purposes

This UI directly writes to SQLite and requires **no code changes** to alter behavior.

---

## Architectural Decisions (Why This Works)

### Why pipelines live in `core`
Pipelines are a **cross-cutting orchestration mechanism** used by:
- Conversations
- Artifacts
- Knowledge processing
- LLM execution

They are not business rules, nor UI logic, so `core` is the correct layer.

---

### Why SQLite stores only configuration
- SQLite cannot and should not know about Dart code
- Step logic is versioned with the app
- Configuration remains stable and editable

This avoids:
- Reflection
- Dynamic code loading
- Fragile runtime behavior

---

### Why steps are resolved via IDs
- Enables reordering and toggling
- Allows adding new steps without refactors
- Makes pipelines serializable and migratable

---

## Current Limitations (Intentional)

This phase intentionally keeps things simple:

- Chunking is naive and placeholder
- Context retrieval is mocked
- No validation of step compatibility
- No UI for step discovery
- No pipeline versioning
- No persistence of artifacts yet

These are **deliberate trade-offs** to keep the system flexible.

---

## Future Refactors & Extensions

### Short-term improvements
- Step registry introspection (list available steps in UI)
- Pipeline validation (missing steps, ordering rules)
- Default / fallback pipelines
- Better error reporting per step

### Medium-term refactors
- Token-based or semantic chunking
- Vector DB-backed context retrieval
- Purpose-aware pipelines (branching)
- Pipeline presets and templates

### Long-term evolution
- Pipeline replay & auditing
- Pipeline versioning & migrations
- Conditional steps
- Pipeline debugging / visualization
- Team-shared pipeline configs (future cloud mode)

---

## Summary

Phase 4 establishes a **foundational execution layer** that turns free-form input and output into structured, purpose-driven data.

It enables:
- Automatic structure
- Configurable intelligence
- Local-first behavior
- Safe extensibility

This phase is a prerequisite for:
- Artifact persistence
- Knowledge graphs
- Memory systems
- Replayable AI workflows

**Phase 4 is now complete and stable.**
