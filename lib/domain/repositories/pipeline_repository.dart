import 'package:aitelier/domain/entities/pipeline/pipeline.dart';

abstract class PipelineRepository {
  Future<List<Pipeline>> getAll();
  Future<Pipeline?> getById(String id);
  Future<void> save(Pipeline pipeline);
  Future<void> delete(String id);
}
