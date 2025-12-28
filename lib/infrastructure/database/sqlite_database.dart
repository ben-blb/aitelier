import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/utils/logger.dart';
import 'migration_runner.dart';
import 'migrations/001_create_conversations_table.dart';

class SqliteDatabase {
  static const _dbName = 'aitelier.db';
  static const _dbVersion = 1;

  static Future<Database> open() async {
    appLogger.i('Opening SQLite database');

    final path = join(await getDatabasesPath(), _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        appLogger.i('Database created, running initial migrations');
        await _runMigrations(db, 0, version);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        appLogger.i(
          'Database upgrade from v$oldVersion to v$newVersion',
        );
        await _runMigrations(db, oldVersion, newVersion);
      },
    );
  }

  static Future<void> _runMigrations(
    Database db,
    int from,
    int to,
  ) async {
    final runner = MigrationRunner([
      CreateConversationsTableMigration(),
    ]);

    await runner.run(db, from, to);
  }
}
