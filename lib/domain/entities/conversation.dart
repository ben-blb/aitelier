import '../value_objects/conversation_id.dart';
import '../value_objects/project_id.dart';
import '../value_objects/conversation_purpose.dart';
import 'conversation_metadata.dart';

class Conversation {
  final ConversationId id;
  final ProjectId projectId;
  final ConversationPurpose purpose;
  final ConversationMetadata metadata;

  const Conversation({
    required this.id,
    required this.projectId,
    required this.purpose,
    required this.metadata,
  });

  factory Conversation.create({
    required ConversationId id,
    required ProjectId projectId,
    required ConversationPurpose purpose,
  }) {
    return Conversation(
      id: id,
      projectId: projectId,
      purpose: purpose,
      metadata: ConversationMetadata.initial(),
    );
  }

  Conversation archive() {
    return Conversation(
      id: id,
      projectId: projectId,
      purpose: purpose,
      metadata: metadata.copyWith(
        isArchived: true,
        updatedAt: DateTime.now(),
      ),
    );
  }
}
