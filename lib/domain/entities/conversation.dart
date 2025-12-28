import '../value_objects/conversation_id.dart';
import '../value_objects/conversation_status.dart';
import '../value_objects/project_id.dart';
import '../value_objects/conversation_purpose.dart';
import 'conversation_metadata.dart';

class Conversation {
  final ConversationId id;
  final String title;
  final ProjectId projectId;
  final ConversationPurpose purpose;
  final ConversationMetadata metadata;
  final ConversationStatus status;

  const Conversation({
    required this.id,
    required this.title,
    required this.projectId,
    required this.purpose,
    required this.metadata,
    required this.status
  });  

  factory Conversation.create({
    required ConversationId id,
    required ProjectId projectId,
    required String title,
    required ConversationPurpose purpose,
  }) {
    return Conversation(
      id: id,
      projectId: projectId,
      title: title,
      status: ConversationStatus.active, // always active by default
      purpose: purpose,
      metadata: ConversationMetadata.initial(),
    );
  }

  Conversation archive() {
    return Conversation(
      id: id,
      projectId: projectId,
      purpose: purpose,
      title: title,
      status: status,
      metadata: metadata.copyWith(
        isArchived: true,
        updatedAt: DateTime.now(),
      ),
    );
  }
}
