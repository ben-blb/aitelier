import '../value_objects/conversation_id.dart';
import '../value_objects/project_id.dart';

abstract class ConversationGitHook {
  Future<void> onMessageAppended({
    required ProjectId projectId,
    required ConversationId conversationId,
    required String purpose,
  });
}
