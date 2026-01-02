import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

class ArtifactProcessingInput {
  final ProjectId projectId;
  final ConversationId conversationId;
  final String purpose;
  final String rawOutput;

  final String? preferredTitle;
  final String? contentTypeHint; // "markdown", "code", etc.

  ArtifactProcessingInput({
    required this.projectId,
    required this.conversationId,
    required this.purpose,
    required this.rawOutput,
    this.preferredTitle,
    this.contentTypeHint,
  });
}
