import 'package:aitelier/core/pipeline/pipeline_registry.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_error.dart';

abstract class PipelineStepHandler {
  String get stepId;

  Future<PipelineContext> execute(PipelineContext context);
}

class PipelineExecutor {
  final PipelineRegistry registry;

  PipelineExecutor(this.registry);

  Future<PipelineContext> execute(
    Pipeline pipeline,
    PipelineContext initialContext,
  ) async {
    if (!pipeline.enabled) {
      return initialContext;
    }

    PipelineContext context = initialContext;

    for (final stepId in pipeline.stepIds) {
      final handler = registry.getHandler(stepId);

      if (handler == null) {
        continue; // Missing step = skip safely
      }

      try {
        context = await handler.execute(context);
      } catch (e, st) {
        throw PipelineError(
          stepId: stepId,
          error: e,
          stackTrace: st,
        );
      }
    }

    return context;
  }
}
