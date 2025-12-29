import 'dart:io';

import '../../domain/services/conversation_git_hook.dart';
import '../../domain/services/git_service.dart';
import '../../domain/value_objects/conversation_id.dart';
import '../../domain/value_objects/project_id.dart';

class LocalConversationGitHook implements ConversationGitHook {
  final Directory root;
  final GitService git;

  LocalConversationGitHook({
    required this.root,
    required this.git,
  });

  @override
  Future<void> onMessageAppended({
    required ProjectId projectId,
    required ConversationId conversationId,
    required String purpose,
  }) async {
    final repositoryPath = '${root.path}/${projectId.value}';

    await git.commitAll(
      repositoryPath,
      'conversation(${conversationId.value}): $purpose message | projectId=${projectId.value}',
    );
  }
}
