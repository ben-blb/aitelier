import 'package:aitelier/infrastructure/conversations/models/conversation_message_record.dart';

import '../../../core/utils/logger.dart';
import '../../../domain/entities/conversation.dart';
import '../../../infrastructure/conversations/models/sqlite_conversation_dao.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class ArchiveConversationUseCase {
  final FileConversationStore fileStore;
  final SqliteConversationDao sqliteDao;

  ArchiveConversationUseCase({
    required this.fileStore,
    required this.sqliteDao,
  });

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
    await sqliteDao.update(archived.id.value);
  }
}
