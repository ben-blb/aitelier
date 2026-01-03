import 'dart:convert';

import 'package:aitelier/core/database/app_database.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline.dart';
import 'package:aitelier/domain/repositories/pipeline_repository.dart';
import 'package:aitelier/infrastructure/pipeline/models/pipeline_dao.dart';

class PipelineRepositoryImpl implements PipelineRepository {
  final PipelineDao dao;

  PipelineRepositoryImpl(this.dao);

  @override
  Future<List<Pipeline>> getAll() async {
    final rows = await dao.getAll();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<Pipeline?> getById(String id) async {
    final row = await dao.getById(id);
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<void> save(Pipeline pipeline) {
    return dao.upsert(_toRow(pipeline));
  }

  @override
  Future<void> delete(String id) {
    return dao.deleteById(id);
  }

  Pipeline _toDomain(PipelinesTableData row) {
    return Pipeline(
      id: row.id,
      name: row.name,
      enabled: row.enabled,
      stepIds: List<String>.from(jsonDecode(row.stepIds)),
    );
  }

  PipelinesTableData _toRow(Pipeline pipeline) {
    return PipelinesTableData(
      id: pipeline.id,
      name: pipeline.name,
      enabled: pipeline.enabled,
      stepIds: jsonEncode(pipeline.stepIds),
    );
  }
}
