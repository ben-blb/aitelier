import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

class PipelineContext {
  final ConversationId conversationId;
  final ProjectId projectId;
  final String input;
  final Map<String, dynamic> metadata;

  PipelineContext({
    required this.input,
    required this.conversationId,
    required this.projectId,
    Map<String, dynamic>? metadata,
  }) : metadata = metadata ?? {};

  PipelineContext copyWith({
    String? input,
    Map<String, dynamic>? metadata,
  }) {
    return PipelineContext(
      input: input ?? this.input,
      conversationId: conversationId,
      projectId: projectId,
      metadata: metadata ?? this.metadata,
    );
  }
}
