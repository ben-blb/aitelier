import 'package:aitelier/application/knowledge/chunking/semantic_chunker.dart';
import 'package:aitelier/domain/entities/knowledge/chunk_source.dart';
import 'package:aitelier/domain/repositories/knowledge_chunk_repository.dart';
import 'package:aitelier/domain/value_objects/chunk_version.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

class CreateChunksUseCase {
  final SemanticChunker chunker;
  final KnowledgeChunkRepository repository;

  CreateChunksUseCase({
    required this.chunker,
    required this.repository,
  });

  Future<void> execute({
    required ProjectId projectId,
    required ChunkSource source,
    required String sourceId,
    required String text,
    required ChunkVersion version,
  }) async {
    final chunks = chunker.chunk(
      projectId: projectId,
      source: source,
      sourceId: sourceId,
      text: text,
      version: version,
    );

    await repository.saveAll(chunks);
  }
}
