class ConversationMetadata {
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;

  const ConversationMetadata({
    required this.createdAt,
    required this.updatedAt,
    required this.isArchived,
  });

  ConversationMetadata copyWith({
    DateTime? updatedAt,
    bool? isArchived,
  }) {
    return ConversationMetadata(
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  factory ConversationMetadata.initial() {
    final now = DateTime.now();
    return ConversationMetadata(
      createdAt: now,
      updatedAt: now,
      isArchived: false,
    );
  }
}
