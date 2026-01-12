import 'package:drift/drift.dart';

class SummariesTable extends Table {
  TextColumn get id => text()();
  TextColumn get scope => text()(); // conversation | project
  TextColumn get scopeId => text()();
  TextColumn get content => text()();
  IntColumn get version => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
