import '../../core/utils/logger.dart';
import '../../domain/services/conversation_git_hook.dart';
import '../../domain/services/git_service.dart';
import '../../domain/value_objects/conversation_id.dart';

class LocalConversationGitHook implements ConversationGitHook {
  final GitService gitService;
  final String repositoryPath;

  LocalConversationGitHook({
    required this.gitService,
    required this.repositoryPath,
  });

  @override
  Future<void> onMessageAppended({
    required ConversationId conversationId,
    required String purpose,
  }) async {
    final commitMessage =
        'conversation($purpose): append message - conv=$conversationId';

    appLogger.i(
      'Git auto-commit triggered | conversation=${conversationId.value} purpose=$purpose',
    );

    try {
      await gitService.commitAll(
        repositoryPath,
        commitMessage,
      );

      appLogger.i(
        'Git commit successful | conversation=${conversationId.value}',
      );
    } catch (e, stack) {
      appLogger.e(
        'Git commit failed | conversation=${conversationId.value}',
        error: e,
        stackTrace: stack
      );
    }
  }
}
