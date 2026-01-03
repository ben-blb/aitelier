import 'package:drift/drift.dart';

class PipelinePurposeTable extends Table {
  TextColumn get purpose => text()();
  TextColumn get pipelineId => text()();

  @override
  Set<Column> get primaryKey => {purpose};
}
