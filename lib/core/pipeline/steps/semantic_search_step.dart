import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:aitelier/infrastructure/llm/llm_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SemanticSearchStep implements PipelineStepHandler {
  final Ref ref;

  SemanticSearchStep(this.ref);

  @override
  String get stepId => 'pre.semantic_search';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    final llmRepository =
        await ref.read(llmRepositoryProvider.future);

    final vectorStore =
        await ref.read(vectorStoreProvider.future);

    final chunkRepository =
        ref.read(knowledgeChunkRepositoryProvider);

    final query = context.input.trim();
    if (query.isEmpty) return context;

    final embedding = await llmRepository.createEmbedding(
      input: query,
      model: 'text-embedding-3-small',
    );

    final hits = await vectorStore.search(
      query: embedding,
      limit: 10,
    );

    final results = <Map<String, dynamic>>[];

    for (final hit in hits) {
      final chunk = await chunkRepository.findById(ChunkId.fromString(hit.id));
      if (chunk == null) continue;

      results.add({
        'chunkId': hit.id,
        'score': hit.score,
        'source': chunk.metadata.source.name,
        'sourceId': chunk.metadata.sourceId,
        'position': chunk.metadata.position,
      });
    }

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['semantic_results'] = results;

    return context.copyWith(metadata: updatedMetadata);
  }
}
