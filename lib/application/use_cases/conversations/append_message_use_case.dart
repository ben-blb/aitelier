import '../../../core/utils/logger.dart';
import '../../../domain/services/conversation_git_hook.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../infrastructure/conversations/models/conversation_message_record.dart';
import '../../../infrastructure/conversations/models/sqlite_conversation_dao.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class AppendMessageUseCase {
  final FileConversationStore fileStore;
  final SqliteConversationDao sqliteDao;
  final ConversationGitHook gitHook;

  AppendMessageUseCase({
    required this.fileStore,
    required this.sqliteDao,
    required this.gitHook
  });

  Future<void> execute({
    required ConversationId conversationId,
    required ConversationMessageRecord message,
  }) async {
    appLogger.d(
      'Appending message | conversation=${conversationId.value}',
    );

    await fileStore.appendMessage(conversationId.value, message);

    await sqliteDao.update(conversationId.value);

    await gitHook.onMessageAppended(
      conversationId: conversationId,
      purpose: message.role,
    );
  }
}
