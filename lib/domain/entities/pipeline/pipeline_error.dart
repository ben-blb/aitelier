class PipelineError implements Exception {
  final String stepId;
  final Object error;
  final StackTrace stackTrace;

  PipelineError({
    required this.stepId,
    required this.error,
    required this.stackTrace,
  });
}
