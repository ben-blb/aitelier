import 'package:aitelier/domain/entities/knowledge/chunk_source.dart';
import 'package:aitelier/domain/entities/knowledge/knowledge_chunk.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

abstract class KnowledgeChunkRepository {
  Future<void> saveAll(List<KnowledgeChunk> chunks);
  Future<List<KnowledgeChunk>> findBySource(
    ProjectId projectId,
    ChunkSource source,
    String sourceId,
  );
}
