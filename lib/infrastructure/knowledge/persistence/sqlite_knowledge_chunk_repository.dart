import 'package:aitelier/domain/entities/knowledge/chunk_source.dart';
import 'package:aitelier/domain/entities/knowledge/knowledge_chunk.dart';
import 'package:aitelier/domain/repositories/knowledge_chunk_repository.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/knowledge/persistence/knowledge_chunk_dao.dart';

class SqliteKnowledgeChunkRepository
    implements KnowledgeChunkRepository {
  final KnowledgeChunkDao dao;

  SqliteKnowledgeChunkRepository(this.dao);

  @override
  Future<void> saveAll(List<KnowledgeChunk> chunks) {
    return dao.insertAll(chunks);
  }

  @override
  Future<List<KnowledgeChunk>> findBySource(
    ProjectId projectId,
    ChunkSource source,
    String sourceId,
  ) {
    return dao.findBySource(projectId, source, sourceId);
  }

  @override
  Future<KnowledgeChunk?> findById(ChunkId id) {
    return dao.findById(id);
  }
}
