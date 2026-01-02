class ConversationMessageRecord {
  final String role;
  final String content;
  final DateTime timestamp;

  ConversationMessageRecord({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  ConversationMessageRecord copyWith({
    String? role,
    String? content,
    DateTime? timestamp,
  }) {
    return ConversationMessageRecord(
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
