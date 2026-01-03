import 'package:aitelier/core/database/app_database.dart';
import 'package:aitelier/core/database/tables/pipeline_tables.dart';
import 'package:drift/drift.dart';

part 'pipeline_dao.g.dart';

@DriftAccessor(tables: [PipelinesTable])
class PipelineDao extends DatabaseAccessor<AppDatabase>
    with _$PipelineDaoMixin {
  PipelineDao(AppDatabase db) : super(db);

  Future<List<PipelinesTableData>> getAll() {
    return select(pipelinesTable).get();
  }

  Future<PipelinesTableData?> getById(String id) {
    return (select(pipelinesTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsert(PipelinesTableData data) {
    return into(pipelinesTable).insertOnConflictUpdate(data);
  }

  Future<void> deleteById(String id) {
    return (delete(pipelinesTable)..where((t) => t.id.equals(id))).go();
  }
}
