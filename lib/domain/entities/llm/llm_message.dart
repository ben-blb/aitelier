enum LLMRole {
  system,
  user,
  assistant
}

class LLMMessage {
  final LLMRole role;
  final String content;

  const LLMMessage({
    required this.role,
    required this.content,
  });
}
