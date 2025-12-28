import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/logger.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/conversation_metadata.dart';
import '../../domain/services/conversation_repository.dart';
import '../../domain/value_objects/conversation_id.dart';
import '../../domain/value_objects/conversation_purpose.dart';
import '../../domain/value_objects/conversation_status.dart';
import '../../domain/value_objects/project_id.dart';

class SQLiteConversationRepository implements ConversationRepository {
  final Database db;

  SQLiteConversationRepository(this.db);

  @override
  Future<Conversation> create({
    required ProjectId projectId,
    required String title,
    required ConversationPurpose purpose,
  }) async {
    final id = const Uuid().v4();
    
    final conversation = Conversation.create(
      id: ConversationId(id),
      projectId: projectId,
      title: title,
      purpose: purpose,
    );

    appLogger.i(
      'Creating conversation | id=${id} project=${projectId.value} purpose=${purpose.value}',
    );


    await db.insert('conversations', _toRow(conversation));

    return conversation;
  }

  @override
  Future<Conversation?> findById(ConversationId id) async {
    appLogger.d('Fetching conversation by id', extra: {
      'conversationId': id.value,
    });

    final rows = await db.query(
      'conversations',
      where: 'id = ?',
      whereArgs: [id.value],
      limit: 1,
    );

    if (rows.isEmpty) return null;

    return _fromRow(rows.first);
  }

  @override
  Future<List<Conversation>> findActiveByProject(ProjectId projectId) async {
    appLogger.d('Fetching active conversations by project', extra: {
      'projectId': projectId.value,
    });

    final rows = await db.query(
      'conversations',
      where: 'project_id = ? AND is_archived = 0',
      whereArgs: [projectId.value],
      orderBy: 'updated_at DESC',
    );

    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> save(Conversation conversation) async {
    appLogger.d('Persisting conversation', extra: {
      'conversationId': conversation.id.value,
      'archived': conversation.metadata.isArchived,
      'status': conversation.status.name,
    });

    await db.update(
      'conversations',
      _toRow(conversation),
      where: 'id = ?',
      whereArgs: [conversation.id.value],
    );
  }

  
  @override
  Future<void> archive(String id) async {
    final now = DateTime.now();

    appLogger.w('Archiving conversation $id');

    await db.update(
      'conversations',
      {
        'status': ConversationStatus.archived.name,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    
    await db.update(
      'conversations',
      {
        'status': ConversationStatus.archived.name,
        'is_archived': 1,
        'updated_at': now.toIso8601String()
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, Object?> _toRow(Conversation conversation) {
    return {
      'id': conversation.id.value,
      'project_id': conversation.projectId.value,
      'title': conversation.title,
      'purpose': conversation.purpose,
      'status': conversation.status.name,
      'created_at': conversation.metadata.createdAt.millisecondsSinceEpoch,
      'updated_at': conversation.metadata.updatedAt.millisecondsSinceEpoch,
      'is_archived': conversation.metadata.isArchived ? 1 : 0,
    };
  }

  Conversation _fromRow(Map<String, Object?> row) {
    return Conversation(
      id: ConversationId(row['id'] as String),
      projectId: ProjectId(row['project_id'] as String),
      title: row['title'] as String,
      purpose: ConversationPurpose(row['purpose'] as String),
      status: ConversationStatus.values.byName(row['status'] as String),
      metadata: ConversationMetadata(
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          row['created_at'] as int,
        ),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(
          row['updated_at'] as int,
        ),
        isArchived: (row['is_archived'] as int) == 1,
      ),
    );
  }
}
