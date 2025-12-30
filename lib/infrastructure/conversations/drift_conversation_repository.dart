import '../../../domain/entities/conversation.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/project_id.dart';
import 'models/conversation_dao.dart';
import 'serializers/conversation_mapper.dart';

class DriftConversationRepository implements ConversationRepository {
  final ConversationDao dao;

  DriftConversationRepository(this.dao);

  @override
  Future<void> create(Conversation conversation) {
    return dao.insertConversation(toDrift(conversation));
  }

  @override
  Future<void> update(Conversation conversation) {
    return dao.updateConversation(toDrift(conversation));
  }

  @override
  Future<Conversation?> getById(ConversationId id) async {
    final row = await dao.findById(id.value);
    return row == null ? null : toEntity(row);
  }

  @override
  Stream<List<Conversation>> watchByProject(ProjectId projectId) {
    return dao.watchByProject(projectId.value).map(
          (rows) => rows.map(toEntity).toList(),
        );
  }

  @override
  Future<void> touch(ConversationId id) {
    return dao.touch(id.value);
  }
}
