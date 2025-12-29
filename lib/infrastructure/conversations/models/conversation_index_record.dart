class ConversationIndexRecord {
  final String id;
  final int messageCount;
  final DateTime lastMessageAt;
  final String lastRole;

  ConversationIndexRecord({
    required this.id,
    required this.messageCount,
    required this.lastMessageAt,
    required this.lastRole,
  });

  ConversationIndexRecord copyWith({
    int? messageCount,
    DateTime? lastMessageAt,
    String? lastRole,
  }) {
    return ConversationIndexRecord(
      id: id,
      messageCount: messageCount ?? this.messageCount,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastRole: lastRole ?? this.lastRole,
    );
  }
}
