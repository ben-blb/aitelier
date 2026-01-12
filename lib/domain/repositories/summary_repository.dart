import 'package:aitelier/domain/entities/knowledge/summary.dart';

abstract class SummaryRepository {
  Future<Summary?> findByScope(
    SummaryScope scope,
    String scopeId,
  );

  Future<void> save(Summary summary);
}
