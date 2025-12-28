# Aitelier — Phase 1 Summary & Changelog
## Conversation Engine (Dumb but Durable)

This document summarizes the implementation of **Phase 1** of the Aitelier architecture, focused on building a durable, local-first conversation engine with clear lifecycle management, purpose enforcement, and Git-backed auditability.

---

## Phase 1 Goals (Achieved)

- Conversations persist across restarts
- Conversations have an explicit purpose
- Messages are append-only and durable
- SQLite is used strictly as an index (not source of truth)
- Git captures conversation history automatically
- Architecture follows Clean Architecture principles
- System is observable via structured logging

---

## Architectural Principles Established

- **Local-first**: Files are the source of truth
- **Append-only**: No destructive writes for conversation content
- **DDD-aligned**: Entities and value objects encapsulate rules
- **Clean Architecture**: Clear separation of domain, application, and infrastructure
- **Side-effect isolation**: Git and IO never block core flows

---

## Phase 1.1 — Conversation Core Model

### Implemented
- `Conversation` aggregate with:
  - `ConversationId`
  - `ProjectId`
  - `ConversationPurpose`
  - `ConversationMetadata`
  - `ConversationStatus`
- Immutable entity design
- Domain-driven lifecycle transitions
- Default creation behavior via factory

### Key Decisions
- Conversations are never deleted
- Archival is a domain operation
- Metadata owns timestamps and archive state

---

## Phase 1.2 — Conversation Storage

### Implemented
- File-based conversation persistence
- JSONL (newline-delimited JSON) format
- Append-only message log
- Stable file layout per project

### Storage Layout
```

/conversations/{projectId}/{conversationId}.jsonl

```

### Design Rationale
- Crash-safe writes
- Git-friendly diffs
- Streamable and replayable
- Scales to long conversations

---

## Phase 1.3 — Purpose Assignment

### Implemented
- Purpose as a first-class value object
- Purpose persisted in:
  - Conversation header (file)
  - SQLite index
- Default purpose enforced at creation
- Purpose propagated to Git commits

### Decisions
- Purpose is immutable per conversation
- Purpose is required at creation time

---

## Phase 1.4 — Purpose DSL Loader (JSON-based)

### Implemented
- JSON-based DSL (YAML explicitly rejected)
- Folder-based loading of purposes via assets
- Schema validation on load
- Purpose registry loaded at startup

### Technical Notes
- Flutter asset system correctly initialized via:
  - `WidgetsFlutterBinding.ensureInitialized()`
- Assets declared explicitly in `pubspec.yaml`
- Loader fails fast with logs if purposes are invalid

---

## Phase 1.5 — Conversation Lifecycle (Reworked)

### Lifecycle Operations
- Create conversation
- Append message
- Archive conversation

### Responsibilities Split

#### Filesystem (Source of Truth)
- Conversation header creation
- Append-only message writes
- Future-proof header updates

#### SQLite (Index Only)
- Fast lookup
- Filtering by project, status, purpose
- Timestamp updates on activity

### Use Cases Added
- `CreateConversationUseCase`
- `AppendMessageUseCase`
- `ArchiveConversationUseCase`

### Guarantees
- File write always happens first
- Index is eventually consistent
- No destructive operations

---

## Phase 1.6 — Git Integration Hook

### Implemented
- Auto-commit on message append
- Purpose included in commit message
- Git treated as a durability side-effect
- Failures logged but never block conversation writes

### Commit Message Format
```

conversation(<purpose>): append message

```

### Integration
- Implemented via `ConversationGitHook`
- Uses existing `GitService`
- Wired into `AppendMessageUseCase`

---

## Logging Strategy

- Uses `logger` with `PrettyPrinter`
- No structured metadata (string-based context instead)
- Logs added for:
  - Conversation creation
  - Message append
  - Archival
  - SQLite index updates
  - Git commit lifecycle
  - Startup/bootstrap errors

### Outcome
- Fully traceable lifecycle
- Debuggable failures
- Future-ready for observability upgrades

---

## Key Fixes & Corrections During Implementation

- Corrected premature asset loading before Flutter bindings
- Enforced `WidgetsFlutterBinding.ensureInitialized()` in bootstrap
- Clarified SQLite role as index, not persistence
- Removed invalid structured logging (`extra`)
- Corrected phase scope confusion (1.6 Git integration)

---

## Phase 1 Exit Criteria (All Met)

- Conversations survive restarts
- Purpose is enforced and persisted
- Git shows conversation history
- Architecture is clean and extensible
- Ready for message modeling and AI context assembly

---

## Suggested Next Phase

**Phase 2 — Message Model & Context Assembly**
- Message entities
- Token accounting
- Context window reconstruction
- AI interaction boundaries

Phase 1 is now **complete and stable**.
