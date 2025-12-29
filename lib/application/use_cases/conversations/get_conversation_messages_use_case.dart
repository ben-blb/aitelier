import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/project_id.dart';
import '../../../infrastructure/conversations/models/conversation_message_record.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class GetConversationMessagesUseCase {
  final FileConversationStore fileStore;

  GetConversationMessagesUseCase({
    required this.fileStore,
  });

  Future<List<ConversationMessageRecord>> execute({
    required ProjectId projectId,
    required ConversationId conversationId,
  }) async {
    return await fileStore.readMessages(
      projectId: projectId.value,
      conversationId: conversationId.value,
    );
  }
}
