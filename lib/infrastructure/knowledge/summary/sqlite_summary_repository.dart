import 'package:aitelier/domain/entities/knowledge/summary.dart';

import './summary_dao.dart';
import 'package:aitelier/domain/repositories/summary_repository.dart';

class SqliteSummaryRepository implements SummaryRepository {
  final SummaryDao dao;

  SqliteSummaryRepository(this.dao);

  @override
  Future<Summary?> findByScope(
    SummaryScope scope,
    String scopeId,
  ) {
    return dao.findByScope(scope, scopeId);
  }

  @override
  Future<void> save(Summary summary) {
    return dao.upsert(summary);
  }
}
