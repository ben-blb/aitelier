import 'package:sqflite/sqflite.dart';
import '../../../core/utils/logger.dart';
import '../models/conversation_record.dart';

class SqliteConversationDao {
  final Database db;

  SqliteConversationDao(this.db);

  Future<void> insertConversation(ConversationRecord record) async {
    appLogger.i('Inserting conversation ${record.id} into SQLite');

    await db.insert(
      'conversations',
      {
        'id': record.id,
        'project_id': record.projectId,
        'purpose_key': record.purposeKey,
        'purpose_description': record.purposeDescription,
        'created_at': record.createdAt.toIso8601String(),
        'updated_at': record.updatedAt.toIso8601String(),
        'is_archived': record.isArchived ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePurpose(
    String conversationId,
    String purposeKey,
    String purposeDescription,
  ) async {
    appLogger.i(
      'Updating purpose for conversation $conversationId to $purposeKey',
    );

    await db.update(
      'conversations',
      {
        'purpose_key': purposeKey,
        'purpose_description': purposeDescription,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [conversationId],
    );
  }

  Future<List<Map<String, dynamic>>> listByProject(
    String projectId,
  ) async {
    appLogger.d('Listing conversations for project $projectId');

    return db.query(
      'conversations',
      where: 'project_id = ? AND is_archived = 0',
      whereArgs: [projectId],
      orderBy: 'updated_at DESC',
    );
  }
}
