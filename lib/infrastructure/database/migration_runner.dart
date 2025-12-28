import 'package:sqflite/sqflite.dart';
import '../../core/utils/logger.dart';
import 'migrations/migration.dart';

class MigrationRunner {
  final List<Migration> migrations;

  MigrationRunner(this.migrations);

  Future<void> run(Database db, int fromVersion, int toVersion) async {
    appLogger.i(
      'Running migrations from v$fromVersion to v$toVersion',
    );

    final pending = migrations
        .where(
          (m) => m.version > fromVersion && m.version <= toVersion,
        )
        .toList()
      ..sort((a, b) => a.version.compareTo(b.version));

    for (final migration in pending) {
      appLogger.i(
        'Applying migration v${migration.version}: ${migration.name}',
      );
      await migration.up(db);
    }
  }
}
