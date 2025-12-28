class PurposeConstraints {
  final bool allowOffTopic;
  final int maxContextTokens;
  final String tone;
  final List<String> forbiddenTopics;

  PurposeConstraints({
    required this.allowOffTopic,
    required this.maxContextTokens,
    required this.tone,
    required this.forbiddenTopics,
  });
}
