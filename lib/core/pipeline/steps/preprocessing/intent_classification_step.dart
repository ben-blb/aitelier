import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class IntentClassificationStep implements PipelineStepHandler {
  @override
  String get stepId => 'pre.intent_classification';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    final text = context.input.toLowerCase();

    String intent;

    if (text.contains('fix') || text.contains('error')) {
      intent = 'debugging';
    } else if (text.contains('design') || text.contains('architecture')) {
      intent = 'architecture';
    } else if (text.contains('implement') || text.contains('code')) {
      intent = 'implementation';
    } else {
      intent = 'general';
    }

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['intent'] = intent;

    return context.copyWith(metadata: updatedMetadata);
  }
}
