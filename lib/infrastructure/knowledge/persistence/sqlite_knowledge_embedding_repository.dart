import 'package:aitelier/domain/entities/embeddings/knowledge_embedding.dart';
import 'package:aitelier/domain/repositories/knowledge_embedding_repository.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/infrastructure/knowledge/persistence/knowledge_embedding_dao.dart';

class SqliteKnowledgeEmbeddingRepository
    implements KnowledgeEmbeddingRepository {
  final KnowledgeEmbeddingDao dao;

  SqliteKnowledgeEmbeddingRepository(this.dao);

  @override
  Future<void> save(KnowledgeEmbedding embedding) {
    return dao.upsert(embedding);
  }

  @override
  Future<KnowledgeEmbedding?> findByChunkId(ChunkId chunkId) {
    return dao.findByChunkId(chunkId);
  }
}
