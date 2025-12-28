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
    ConversationPurpose? purpose,
  }) async {
    final resolvedPurpose = purpose ??
        const ConversationPurpose(
          key: 'general',
          description: 'General conversation',
        );

    appLogger.i(
      'Creating conversation ${id.value} with purpose ${resolvedPurpose.key}',
    );

    final conversation = Conversation.create(
      id: id,
      projectId: projectId,
      purpose: resolvedPurpose,
    );

    final record = ConversationRecord(
      id: id.value,
      projectId: projectId.value,
      purposeKey: resolvedPurpose.key,
      purposeDescription: resolvedPurpose.description,
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
