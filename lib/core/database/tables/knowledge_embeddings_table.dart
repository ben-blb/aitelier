import 'package:drift/drift.dart';

class KnowledgeEmbeddingsTable extends Table {
  TextColumn get chunkId => text()();
  IntColumn get version => integer()();
  TextColumn get model => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {chunkId};
}
