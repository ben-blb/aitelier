import 'package:aitelier/domain/entities/conversation.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/conversations/drift_conversation_repository.dart';

class ListConversationsByProjectUseCase {
  final DriftConversationRepository repository;

  ListConversationsByProjectUseCase(this.repository);

  Future<List<Conversation>> execute(ProjectId projectId) async {
    return repository.listByProject(projectId);
  }
}
