import '../entities/conversation.dart';
import '../value_objects/conversation_purpose.dart';
import '../value_objects/project_id.dart';

abstract class ConversationRepository {
  Future<Conversation> create({
    required ProjectId projectId,
    required String title,
    required ConversationPurpose purpose
  });
  Future<Conversation?> findById(String id);
  Future<List<Conversation>> findActive();
  Future<void> update(Conversation conversation);
  Future<void> archive(String id);
}
