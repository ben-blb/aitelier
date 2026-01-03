
import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class ArtifactEnrichmentStep implements PipelineStepHandler {
  @override
  String get stepId => 'post.artifact_enrichment';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    final chunks = context.metadata['chunks'];

    if (chunks is! List<String>) {
      return context;
    }

    final artifacts = chunks.map((chunk) {
      return {
        'type': 'text',
        'content': chunk,
        'metadata': {
          'length': chunk.length,
        },
      };
    }).toList();

    final metadata = Map<String, dynamic>.from(context.metadata)
      ..['artifacts'] = artifacts;

    return context.copyWith(metadata: metadata);
  }
}
