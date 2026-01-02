class ArtifactProcessingInput {
  final String conversationId;
  final String purpose;
  final String rawOutput;

  final String? preferredTitle;
  final String? contentTypeHint; // "markdown", "code", etc.

  ArtifactProcessingInput({
    required this.conversationId,
    required this.purpose,
    required this.rawOutput,
    this.preferredTitle,
    this.contentTypeHint,
  });
}
