import 'package:sqflite/sqflite.dart';
import 'migration.dart';
import '../../../core/utils/logger.dart';

class CreateConversationsTableMigration implements Migration {
  @override
  int get version => 1;

  @override
  String get name => 'create_conversations_table';

  @override
  Future<void> up(Database db) async {
    appLogger.i('Running migration v$version: $name');

    await db.execute('''
      CREATE TABLE conversations (
        id TEXT PRIMARY KEY,
        project_id TEXT NOT NULL,
        title TEXT NOT NULL,        
        status TEXT NOT NULL,
        purpose_key TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        is_archived INTEGER NOT NULL
      );
    ''');
  }
}
