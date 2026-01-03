import 'package:drift/drift.dart';

class PipelinesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get stepIds => text()(); // JSON array
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
