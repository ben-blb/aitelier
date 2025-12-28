class ConversationPurpose {
  final String key;
  final String description;

  const ConversationPurpose({
    required this.key,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationPurpose && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
