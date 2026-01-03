enum PipelineStepType {
  preprocessing,
  postprocessing,
  generic,
}

class PipelineStep {
  final String id;
  final PipelineStepType type;
  final bool enabled;

  PipelineStep({
    required this.id,
    required this.type,
    required this.enabled,
  });
}
