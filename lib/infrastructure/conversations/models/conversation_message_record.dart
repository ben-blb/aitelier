class ConversationMessageRecord {
  final String role;
  final String content;
  final DateTime timestamp;

  ConversationMessageRecord({
    required this.role,
    required this.content,
    required this.timestamp,
  });
}
