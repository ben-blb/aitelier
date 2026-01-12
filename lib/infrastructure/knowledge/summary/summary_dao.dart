import 'package:aitelier/core/database/app_database.dart';
import 'package:aitelier/core/database/tables/summaries_table.dart';
import 'package:drift/drift.dart';
import '../../../domain/entities/knowledge/summary.dart';

part 'summary_dao.g.dart';

@DriftAccessor(tables: [SummariesTable])
class SummaryDao extends DatabaseAccessor<AppDatabase>
    with _$SummaryDaoMixin {
  SummaryDao(super.db);

  // ------------------------------------------------------------
  // QUERIES
  // ------------------------------------------------------------

  Future<Summary?> findByScope(
    SummaryScope scope,
    String scopeId,
  ) async {
    final row = await (select(summariesTable)
          ..where((t) =>
              t.scope.equals(scope.name) &
              t.scopeId.equals(scopeId)))
        .getSingleOrNull();

    if (row == null) return null;

    return _fromRow(row);
  }

  // ------------------------------------------------------------
  // INSERT / UPDATE
  // ------------------------------------------------------------

  Future<void> upsert(Summary summary) {
    return into(summariesTable).insertOnConflictUpdate(
      SummariesTableCompanion.insert(
        id: summary.id,
        scope: summary.scope.name,
        scopeId: summary.scopeId,
        content: summary.content,
        version: summary.version,
        updatedAt: summary.updatedAt,
      ),
    );
  }

  // ------------------------------------------------------------
  // MAPPER
  // ------------------------------------------------------------

  Summary _fromRow(SummariesTableData row) {
    return Summary(
      id: row.id,
      scope: SummaryScope.values.byName(row.scope),
      scopeId: row.scopeId,
      content: row.content,
      version: row.version,
      updatedAt: row.updatedAt,
    );
  }
}
