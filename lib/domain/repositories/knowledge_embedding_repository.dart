import 'package:aitelier/domain/entities/embeddings/knowledge_embedding.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';

abstract class KnowledgeEmbeddingRepository {
  Future<void> save(KnowledgeEmbedding embedding);
  Future<KnowledgeEmbedding?> findByChunkId(ChunkId id);
}
