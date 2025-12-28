class ConversationRecord {
  final String id;
  final String projectId;
  final String purposeKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;

  ConversationRecord({
    required this.id,
    required this.projectId,
    required this.purposeKey,
    required this.createdAt,
    required this.updatedAt,
    required this.isArchived,
  });
}
