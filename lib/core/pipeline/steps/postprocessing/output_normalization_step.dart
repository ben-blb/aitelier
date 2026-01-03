
import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class OutputNormalizationStep implements PipelineStepHandler {
  @override
  String get stepId => 'post.output_normalization';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    final normalized = context.input
        .trim()
        .replaceAll('\r\n', '\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n');

    final metadata = Map<String, dynamic>.from(context.metadata)
      ..['normalized_output'] = normalized;

    return context.copyWith(
      input: normalized,
      metadata: metadata,
    );
  }
}
