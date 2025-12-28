import 'package:aitelier/domain/services/conversation_repository.dart';
import 'package:aitelier/infrastructure/conversations/models/conversation_message_record.dart';

import '../../../core/utils/logger.dart';
import '../../../domain/entities/conversation.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class ArchiveConversationUseCase {
  final FileConversationStore fileStore;
  final ConversationRepository indexRepository;

  ArchiveConversationUseCase(
    this.fileStore,
    this.indexRepository,
  );

  Future<void> execute(Conversation conversation) async {
    final archived = conversation.archive();

    appLogger.w(
      'Archiving conversation | id=${conversation.id.value}',
    );

    await fileStore.appendMessage(
      archived.id.value,
      ConversationMessageRecord(
        role: 'system',
        content: 'archived',
        timestamp: archived.metadata.updatedAt
      ));
    await indexRepository.update(archived);
  }
}
