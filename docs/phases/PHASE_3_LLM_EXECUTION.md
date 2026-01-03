# Phase 3 — LLM Execution (Minimum Viable Intelligence)

## Goal

Enable one LLM to work end-to-end with:

* provider abstraction
* secure key handling
* real streaming execution
* UI streaming output
* guaranteed artifact capture

This phase establishes the **execution spine** of Aitelier.

---

## 3.1 LLM Provider Abstraction

### What Was Implemented

* Provider-agnostic LLM execution contract
* Strong separation between:

  * domain prompt model
  * application orchestration
  * infrastructure adapters
* Streaming-first design

### Key Abstractions

* `LLMRepository`
* `LLMProvider`
* `LLMExecutionRequest`
* `LLMStreamChunk`
* `PromptBuilder`
* `ExecutePromptUseCase`

### Result

The application can execute prompts without knowing:

* which provider is used
* how HTTP is performed
* how streaming works internally

---

## 3.2 OpenAI Adapter (Direct)

### What Was Implemented

* OpenAI implemented strictly as an adapter
* Secure API key retrieval via existing `SecretStorage`
* Typed OpenAI request/response models
* Error propagation without leaking provider details
* Riverpod-based dependency injection

### Key Components

* `OpenAIClient`
* `OpenAILLMProvider`
* `OpenAIChatRequest`
* `OpenAIChatResponse`
* Riverpod async providers for:

  * HTTP client
  * OpenAI client
  * LLM repository

### Result

OpenAI can be swapped later without touching:

* UI
* conversation logic
* artifact system

---

## 3.3 Prompt Execution Flow

### What Was Implemented

* Prompt construction from conversation history
* Execution triggered from the existing `ConversationController`
* Streaming orchestration integrated into the same controller
* No duplicate notifiers or state sources

### Execution Flow

```
ConversationController.sendMessage
  → PromptBuilder
  → ExecutePromptUseCase
  → LLMRepository
  → OpenAILLMProvider
  → OpenAIClient
```

### Result

* One controller owns:

  * persistence
  * streaming updates
  * LLM execution
* UI remains unchanged
* Streaming updates flow naturally through state updates

---

## 3.4 Output Capture (Artifacts)

### What Was Implemented

* Guaranteed artifact capture for every LLM execution
* Reuse of existing artifact pipeline
* Mandatory use of `GenericArtifactProcessor`
* Proper metadata normalization for JSON safety

### Key Rules Enforced

* LLM output always becomes an artifact
* No branching by purpose
* No UI involvement
* Provenance, versioning, indexing preserved

### Integration Point

Artifact processing is triggered **after streaming completes** inside `ConversationController`.

### Result

* All LLM outputs are durable
* Artifacts remain auditable and indexable
* No duplication of artifact logic

---

## 3.5 UI Integration (Streaming Markdown View)

### What Was Implemented

* Streaming response rendering in the existing conversation UI
* Markdown support for assistant messages
* Plain text for user messages
* PoC-level renderer using `flutter_markdown`

### Why It Works

* Assistant message content is updated incrementally
* Widget rebuilds naturally
* Markdown re-renders as text grows

No new UI state or controllers were introduced.

---

## Real Streaming Fix (Critical)

### Problem Identified

Initial implementation yielded a single chunk, resulting in fake streaming.

### Fix Applied

* Added streaming support to `HttpClient`
* Implemented SSE-based streaming in `OpenAIClient`
* Parsed OpenAI stream events incrementally
* Updated `OpenAILLMProvider.stream` to yield tokens as they arrive

### Result

* True token-by-token streaming
* Visible typing effect in UI
* Streaming markdown fully functional

---

## Key Architectural Outcomes

* Clean Architecture preserved
* Riverpod async lifecycle handled correctly
* No domain objects leaked into infrastructure serialization
* One source of truth for conversations
* LLM execution fully decoupled from UI

---

## Phase 3 Exit Criteria — Met

* ✔ One prompt → one execution → one artifact
* ✔ Secrets stored securely
* ✔ Real streaming output
* ✔ Markdown rendering
* ✔ Provider abstraction enforced
* ✔ No UI rewrites

---

## What Phase 3 Unlocks

* Multi-provider routing (Phase 4)
* Artifact navigation and previews
* Advanced streaming UX
* Hybrid local/cloud LLM execution
* Future “Avengers Doomsday” refactor without rewrites

---

**Phase 3 establishes Aitelier’s execution core.**
Everything beyond this is iteration, not reinvention.
