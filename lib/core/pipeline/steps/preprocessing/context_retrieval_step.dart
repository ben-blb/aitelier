
import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class ContextRetrievalStep implements PipelineStepHandler {
  @override
  String get stepId => 'pre.context_retrieval';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    // MOCK — to be replaced by vector/graph lookup later
    final retrievedContext = [
      'Project: Local-first AI workspace',
      'Architecture: Clean Architecture + Flutter',
    ];

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['retrieved_context'] = retrievedContext;

    return context.copyWith(metadata: updatedMetadata);
  }
}
