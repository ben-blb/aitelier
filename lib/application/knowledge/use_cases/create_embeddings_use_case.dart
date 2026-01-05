import 'package:aitelier/domain/entities/embeddings/knowledge_embedding.dart';
import 'package:aitelier/domain/entities/knowledge/knowledge_chunk.dart';
import 'package:aitelier/domain/value_objects/embedding_version.dart';
import 'package:aitelier/domain/repositories/knowledge_embedding_repository.dart';
import 'package:aitelier/domain/repositories/llm_repository.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/vector_store.dart';

class CreateEmbeddingsUseCase {
  final LLMRepository llmRepository;
  final KnowledgeEmbeddingRepository embeddingRepository;
  final VectorStore vectorStore;

  CreateEmbeddingsUseCase({
    required this.llmRepository,
    required this.embeddingRepository,
    required this.vectorStore,
  });

  Future<void> execute({
    required KnowledgeChunk chunk,
    required String chunkText,
    required EmbeddingVersion version,
    String model = 'text-embedding-3-small',
  }) async {
    // 1. Generate embedding via LLM repository
    final vector = await llmRepository.createEmbedding(
      input: chunkText,
      model: model,
    );

    // 2. Store vector in vector DB
    await vectorStore.upsert(
      id: chunk.id.value,
      vector: vector,
      metadata: {
        'projectId': chunk.metadata.projectId.value,
        'source': chunk.metadata.source.name,
        'sourceId': chunk.metadata.sourceId,
        'position': chunk.metadata.position,
      },
    );

    // 3. Persist embedding metadata (SQLite)
    await embeddingRepository.save(
      KnowledgeEmbedding(
        chunkId: chunk.id,
        version: version,
        model: model,
        createdAt: DateTime.now(),
      ),
    );
  }
}
