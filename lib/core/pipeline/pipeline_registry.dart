import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';

class PipelineRegistry {
  final Map<String, PipelineStepHandler> _handlers = {};

  void register(PipelineStepHandler handler) {
    _handlers[handler.stepId] = handler;
  }

  PipelineStepHandler? getHandler(String stepId) {
    return _handlers[stepId];
  }
}
