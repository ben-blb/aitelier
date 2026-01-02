class LLMStreamChunk {
  final String content;
  final bool isFinal;

  const LLMStreamChunk({
    required this.content,
    required this.isFinal,
  });
}
