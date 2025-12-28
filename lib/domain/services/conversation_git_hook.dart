import '../value_objects/conversation_id.dart';

abstract class ConversationGitHook {
  Future<void> onMessageAppended({
    required ConversationId conversationId,
    required String purpose,
  });
}
