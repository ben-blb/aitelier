import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

abstract class PipelineStepHandler {
  String get stepId;

  Future<PipelineContext> execute(PipelineContext context);
}
