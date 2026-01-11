import 'package:drift/drift.dart';

class VectorTable extends Table {
  TextColumn get id => text()(); // chunkId
  BlobColumn get vector => blob()(); // Float64List bytes
  TextColumn get metadata => text()(); // JSON
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
