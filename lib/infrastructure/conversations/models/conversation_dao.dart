import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/conversations_table.dart';

part 'conversation_dao.g.dart';
@DriftAccessor(tables: [Conversations])
class ConversationDao extends DatabaseAccessor<AppDatabase>
    with _$ConversationDaoMixin {

  ConversationDao(super.db);

  Future<void> insertConversation(Conversation row) =>
      into(conversations).insert(row);

  Future<void> updateConversation(Conversation row) =>
      update(conversations).replace(row);

  Future<Conversation?> findById(String id) {
    return (select(conversations)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<List<Conversation>> watchByProject(String projectId) {
    return (select(conversations)
          ..where((c) =>
              c.projectId.equals(projectId) & c.isArchived.equals(false))
          ..orderBy([
            (c) => OrderingTerm.desc(c.updatedAt),
          ]))
        .watch();
  }

  Future<void> touch(String conversationId) {
    return (update(conversations)
          ..where((c) => c.id.equals(conversationId)))
        .write(
          ConversationsCompanion(
            updatedAt: Value(DateTime.now()),
          ),
        );
  }
}
