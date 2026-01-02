import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/artifacts/models/artifact_summary.dart';

import '../../../infrastructure/artifacts/index/artifact_lookup_service.dart';

class ListArtifactsByConversation {
  final ArtifactLookupService lookup;

  ListArtifactsByConversation({required this.lookup});

  Future<List<ArtifactSummary>> call(ProjectId projectId,ConversationId conversationId) {
    return lookup.findByConversation(conversationId.value, projectId);
  }
}
