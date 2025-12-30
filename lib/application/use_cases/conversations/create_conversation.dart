import '../../../core/utils/logger.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/conversation_purpose.dart';
import '../../../domain/value_objects/project_id.dart';
import '../../../infrastructure/conversations/drift_conversation_repository.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class CreateConversationUseCase {
  final FileConversationStore fileStore;
  final DriftConversationRepository conversationRepository;

  CreateConversationUseCase({
    required this.fileStore,
    required this.conversationRepository,
  });

  Future<Conversation> execute({
    required ConversationId id,
    required ProjectId projectId,
    required String title,
    ConversationPurpose? purpose,
  }) async {
    final resolvedPurpose = purpose ?? ConversationPurpose('general');

    appLogger.i(
      'Creating conversation ${id.value} with purpose ${resolvedPurpose.value}',
    );

    final conversation = Conversation.create(
      id: id,
      title: title,
      projectId: projectId,
      purpose: resolvedPurpose,
    );

    await fileStore.createConversation(conversation);
    await conversationRepository.create(conversation);

    appLogger.i('Conversation ${id.value} created successfully');

    return conversation;
  }
}
