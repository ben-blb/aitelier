class PipelineContext {
  final String input;
  final Map<String, dynamic> metadata;

  PipelineContext({
    required this.input,
    Map<String, dynamic>? metadata,
  }) : metadata = metadata ?? {};

  PipelineContext copyWith({
    String? input,
    Map<String, dynamic>? metadata,
  }) {
    return PipelineContext(
      input: input ?? this.input,
      metadata: metadata ?? this.metadata,
    );
  }
}
