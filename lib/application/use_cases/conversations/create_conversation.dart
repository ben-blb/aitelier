import '../../../core/utils/logger.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/conversation_purpose.dart';
import '../../../domain/value_objects/project_id.dart';
import '../../../infrastructure/conversations/models/conversation_record.dart';
import '../../../infrastructure/conversations/models/sqlite_conversation_dao.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class CreateConversationUseCase {
  final FileConversationStore fileStore;
  final SqliteConversationDao sqliteDao;

  CreateConversationUseCase({
    required this.fileStore,
    required this.sqliteDao,
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

    final record = ConversationRecord(
      id: id.value,
      projectId: projectId.value,
      purposeKey: resolvedPurpose.value,
      createdAt: conversation.metadata.createdAt,
      updatedAt: conversation.metadata.updatedAt,
      isArchived: conversation.metadata.isArchived,
    );

    await fileStore.createConversation(record);
    await sqliteDao.insertConversation(record);

    appLogger.i('Conversation ${id.value} created successfully');

    return conversation;
  }
}
