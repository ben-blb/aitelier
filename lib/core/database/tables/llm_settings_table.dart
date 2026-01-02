import 'package:drift/drift.dart';

class LlmSettingsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get provider => text()();
  TextColumn get model => text()();
  BoolColumn get streaming => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();
}
