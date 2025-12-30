
import '../../../core/database/app_database.dart' as db;

import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/conversation_metadata.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/project_id.dart';
import '../../../domain/value_objects/conversation_purpose.dart';
import '../../../domain/value_objects/conversation_status.dart';

Conversation toEntity(db.Conversation row) {
  return Conversation(
    id: ConversationId(row.id),
    projectId: ProjectId(row.projectId),
    title: row.title,
    purpose: ConversationPurpose(row.purpose),
    status: ConversationStatus.values.firstWhere(
      (e) => e.name == row.status,
      orElse: () => ConversationStatus.active,
    ),
    metadata: ConversationMetadata(
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isArchived: row.isArchived,
    ),
  );
}

db.Conversation toDrift(Conversation entity) {
  return db.Conversation(
    id: entity.id.value,
    projectId: entity.projectId.value,
    title: entity.title,
    purpose: entity.purpose.value,
    status: entity.status.name,
    isArchived: entity.metadata.isArchived,
    createdAt: entity.metadata.createdAt,
    updatedAt: entity.metadata.updatedAt,
  );
}
