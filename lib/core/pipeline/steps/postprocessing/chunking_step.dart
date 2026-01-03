import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class ChunkingStep implements PipelineStepHandler {
  @override
  String get stepId => 'post.chunking';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    // MOCK IMPLEMENTATION
    final chunks = context.input
        .split('\n\n')
        .where((c) => c.trim().isNotEmpty)
        .toList();

    final metadata = Map<String, dynamic>.from(context.metadata)
      ..['chunks'] = chunks;

    return context.copyWith(metadata: metadata);
  }
}
