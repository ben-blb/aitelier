import 'package:aitelier/core/database/app_database.dart';
import 'package:aitelier/core/database/tables/pipeline_purpose_table.dart';
import 'package:drift/drift.dart';


part 'pipeline_purpose_dao.g.dart';

@DriftAccessor(tables: [PipelinePurposeTable])
class PipelinePurposeDao extends DatabaseAccessor<AppDatabase>
    with _$PipelinePurposeDaoMixin {
  PipelinePurposeDao(super.db);

  Future<PipelinePurposeTableData?> getByPurpose(String purpose) {
    return (select(pipelinePurposeTable)
          ..where((t) => t.purpose.equals(purpose)))
        .getSingleOrNull();
  }

  Future<void> upsert(PipelinePurposeTableData data) {
    return into(pipelinePurposeTable).insertOnConflictUpdate(data);
  }
}
