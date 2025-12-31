We are refactoring to make this thing cooler.
Here is your documentation guide for the new architecture. You can place this in your project's `README.md` or a `docs/ARCHITECTURE.md` file.

### **How to Add New Features (Step-by-Step)**

When you need to add a new feature (e.g., "Deleting a Conversation"), follow this flow to maintain Clean Architecture compliance.

#### **Step 1: Define the Use Case (Application Layer)**

Create the class that contains the business logic. It should rely on abstract interfaces (Repositories), not concrete implementations.

* **Location:** `lib/application/use_cases/conversations/delete_conversation_use_case.dart`

```dart
class DeleteConversationUseCase {
  final ConversationRepository repository;

  DeleteConversationUseCase({required this.repository});

  Future<void> execute(ConversationId id) async {
    return repository.delete(id);
  }
}

```

#### **Step 2: Register the Provider (Dependency Injection)**

Go to your dependencies file. You never manually instantiate the Use Case in your UI widgets; you register it here.

* **Location:** `lib/dependencies.dart` (or `lib/core/di/dependencies.dart`)

```dart
// Add this new provider
final deleteConversationUseCaseProvider = Provider<DeleteConversationUseCase>((ref) {
  // 'ref' allows you to read other providers (like the repository)
  return DeleteConversationUseCase(
    repository: ref.watch(conversationRepoProvider),
  );
});

```

#### **Step 3: Update the Controller (Presentation Layer)**

The Controller (Notifier) bridges the UI and the Logic. It handles the state (loading, error, success).

* **Location:** `lib/presentation/features/conversations/conversation_list_controller.dart`

```dart
class ProjectConversationsController extends FamilyAsyncNotifier<List<Conversation>, ProjectId> {
  // 1. Lazy load the new Use Case
  late final _deleteConversation = ref.read(deleteConversationUseCaseProvider);

  // ... existing build method ...

  // 2. Add the method for the UI to call
  Future<void> delete(ConversationId id) async {
    // Optimistic update: Remove from UI immediately
    final previousState = state.value;
    if (previousState != null) {
      state = AsyncData(previousState.where((c) => c.id != id).toList());
    }

    try {
      // Call the Use Case
      await _deleteConversation.execute(id);
    } catch (e) {
      // Revert if failed
      state = AsyncError(e, StackTrace.current);
      ref.invalidateSelf(); // Reload data to be safe
    }
  }
}

```

#### **Step 4: Connect the UI (Presentation Layer)**

The UI remains "dumb." It just renders data and calls the controller methods.

* **Location:** `lib/presentation/features/conversations/project_conversations_screen.dart`

```dart
// inside your ListView builder...
IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
    // Call the controller method we just made
    ref.read(projectConversationsProvider(projectId).notifier).delete(convo.id);
  },
)

```

---

### **Architecture Migration Summary (Changelog)**

**Version:** 2.0 (Migration to Riverpod DI)
**Date:** [Current Date]
**Summary:** Replaced manual Dependency Injection (`AppContainer`) with a reactive, compile-safe Service Locator using Riverpod.

#### **Key Changes**

1. **Removed `AppContainer`:**
* **Old Way:** A monolithic class passed manually through constructors ("prop drilling") from `main.dart` down to leaf widgets.
* **New Way:** Dependencies are defined as global `Provider`s in `dependencies.dart`. Any widget or class can access them cleanly using `ref.read` or `ref.watch`.


2. **Bootstrap Refactor:**
* **Old Way:** `bootstrapApp` created the container and passed it to `runApp`.
* **New Way:** `bootstrapApp` initializes core services (DB, filesystem) and injects them into the `ProviderScope` via overrides.


3. **Controllers & State Management:**
* **Old Way:** `StatefulWidget`s managed their own loading states (`isLoading` bools) and data lists. Logic was mixed with UI code.
* **New Way:** `AsyncNotifier` (Riverpod) separates logic from UI.
* **UI:** Purely reactive. Watches the provider state.
* **Logic:** Encapsulated in the Notifier. Handles `try/catch`, loading states, and optimistic updates automatically.




4. **Resolved `WorkspacePage` Conflict:**
* The `WorkspacePage` previously re-initialized the filesystem manually, breaking the single-source-of-truth rule. It now consumes the shared `localWorkspaceStorageProvider`, ensuring consistency across the app.



#### **Benefits**

* **Zero Prop Drilling:** No need to pass `container` down the widget tree.
* **Testability:** Any Use Case or Repository can be mocked easily in tests by overriding the provider.
* **Consistency:** All features (Projects, Conversations) now follow the exact same architectural pattern.
* **Automatic Lifecycle:** Providers can be set to `autoDispose` to automatically close connections or clear caches when screens are closed (optional).