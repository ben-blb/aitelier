
## 📄 PHASE_0_SYSTEM_SKELETON.md

# PHASE 0 — System Skeleton (Non-Negotiable)

This document records the complete implementation of **Phase 0** of the Aitelier project.

Phase 0 establishes a **local-first, deterministic, secure foundation** upon which all future functionality will be built.  
No intelligence, automation, or AI behavior is introduced at this stage.

---

## 🎯 Phase Goal

- App boots reliably
- State is persisted locally
- Projects exist on disk
- Git history tracks all changes
- Secrets are stored securely
- Architecture boundaries are enforced from day one

---

## 🧱 Architectural Principles

- Clean Architecture enforced strictly
- Domain is pure and immutable
- Application orchestrates workflows
- Infrastructure handles side effects
- Presentation contains no business logic
- Local-first by default
- Deterministic behavior over convenience

---

## 📁 Final Project Structure (Authoritative)

```

lib/
├── main.dart
├── app.dart
├── bootstrap.dart
│
├── core/
│   ├── errors/
│   ├── utils/
│
├── domain/
│   ├── entities/
│   │   └── project.dart
│   │
│   └── services/
│       ├── project_repository.dart
│       ├── git_service.dart
│       └── secret_storage.dart
│
├── application/
│   └── use_cases/
│       └── initialize_workspace.dart
│       └── project/
│           ├── create_project.dart
│           ├── delete_project.dart
│           ├── list_projects.dart
│           ├── update_project_remote.dart
│           └── sync_project.dart
│
├── infrastructure/
│   ├── storage/
│   │   ├── local_file_system.dart
│   │   └── local_project_repository.dart
│   │   └── local_workspace_storage.dart
│   │
│   ├── git/
│   │   └── local_git_service.dart
│   │
│   └── security/
│       └── secure_storage_adapter.dart
│
└── presentation/
│   ├── app_shell/
│   │   └── app_scaffold.dart
│   └── features/
│       └── workspace/
│           └── secure_storage_adapter.dart
```

---

## 🔹 PHASE 0.1 — App Initialization

### Completed
- Flutter desktop app initialized
- Platform targets configured
- Centralized bootstrap flow created
- Logging utilities added
- Global error handling defined
- App entry kept thin and deterministic

### Outcome
The app launches reliably and is structurally ready for extension.

---

## 🔹 PHASE 0.2 — Workspace Management

### Completed
- Workspace root defined and persisted
- Workspace discovery implemented
- Workspace bootstrap flow enforced
- Workspace metadata stored locally

### Outcome
The system always operates inside a known workspace boundary.

---

## 🔹 PHASE 0.3 — Project Management (Local)

### Completed
- Project domain entity defined (immutable)
- Project lifecycle formalized
- Local project persistence implemented
- Project metadata stored as `project.json`
- Repository contract expanded to support full lifecycle

### Project Entity (Canonical Fields)
- id
- name
- description
- createdAt
- rootPath
- remoteUrl (optional)

### Outcome
Projects are first-class citizens with deterministic state.

---

## 🔹 PHASE 0.4 — Local File System Abstraction

### Completed
- File system access abstracted
- Path normalization enforced
- Atomic writes implemented
- Directory-based project storage adopted

### Outcome
Infrastructure concerns are isolated and replaceable.

---

## 🔹 PHASE 0.5 — Git Integration (Foundational)

### Completed
- Embedded Git client integrated
- Git repositories initialized per project
- Deterministic commits enforced
- Automatic staging implemented
- Optional remote repository support added
- Explicit sync (push) use case introduced
- Remote URLs persisted in project metadata
- Git operations isolated in infrastructure layer

### Design Decisions
- Git init occurs before metadata writes
- No auto-push on commit
- Sync is explicit and user-controlled
- Local-first workflow preserved

### Outcome
Every state change is tracked and reproducible.

---

## 🔹 PHASE 0.6 — Secure Local Secret Storage

### Completed
- Secret storage contract defined in domain
- OS-native secure storage adapter implemented
- Secrets never touch disk in plaintext
- Secrets never enter Git
- Platform-specific encryption delegated to OS

### Backend Used
- `flutter_secure_storage`
  - Keychain (macOS)
  - Credential Manager (Windows)
  - Keyring (Linux)

### Outcome
Security debt is eliminated at the foundation level.

---

## ✅ Phase 0 Exit Criteria — PASSED

- ✔ App launches
- ✔ Workspace exists on disk
- ✔ Projects are persisted locally
- ✔ Git history records state changes
- ✔ Remote repositories supported
- ✔ Secrets stored securely
- ✔ Clean Architecture enforced

---

## 🧠 Phase 0 Philosophy

Phase 0 prioritizes **correctness, determinism, and security** over features.

No intelligence was added.
No automation was assumed.
No shortcuts were taken.

This foundation enables rapid, safe development in future phases.

---

## ➡️ Next Phases

- PHASE 1 — Artifact ingestion & routing
- PHASE 1.1 — Project & workspace UI flows
- PHASE 2 — Intelligence & AI integration

Phase 0 is complete.
