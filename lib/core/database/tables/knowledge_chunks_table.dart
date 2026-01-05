import 'package:drift/drift.dart';

class KnowledgeChunksTable extends Table {
  TextColumn get id => text()();
  TextColumn get projectId => text()();
  TextColumn get source => text()();
  TextColumn get sourceId => text()();
  IntColumn get position => integer()();
  IntColumn get charStart => integer()();
  IntColumn get charEnd => integer()();
  IntColumn get version => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
