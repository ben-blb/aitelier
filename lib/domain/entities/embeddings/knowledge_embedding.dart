import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/domain/value_objects/embedding_version.dart';

class KnowledgeEmbedding {
  final ChunkId chunkId;
  final EmbeddingVersion version;
  final String model;
  final DateTime createdAt;

  KnowledgeEmbedding({
    required this.chunkId,
    required this.version,
    required this.model,
    required this.createdAt,
  });
}
