import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';
import 'package:uuid/uuid.dart';

class ArtifactEnrichmentStep implements PipelineStepHandler {
  static const _uuid = Uuid();

  @override
  String get stepId => 'post.artifact_enrichment';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    final chunks = context.metadata['chunks'];

    if (chunks is! List<String> || chunks.isEmpty) {
      return context;
    }

    final artifacts = chunks.map((chunk) {
      return {
        'id': _uuid.v4(),
        'type': 'text',
        'content': chunk,
        'metadata': {
          'length': chunk.length,
          'semantic_refs': <Map<String, dynamic>>[],
        },
      };
    }).toList();

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['artifacts'] = artifacts;

    return context.copyWith(metadata: updatedMetadata);
  }
}
