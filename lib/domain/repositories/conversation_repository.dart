import '../entities/conversation.dart';
import '../value_objects/conversation_id.dart';
import '../value_objects/project_id.dart';

abstract class ConversationRepository {
  Future<void> create(Conversation conversation);
  Future<void> update(Conversation conversation);
  Future<void> touch(ConversationId id);
  Future<Conversation?> getById(ConversationId id);
  Future<List<Conversation>> listByProject(ProjectId projectId);
}
