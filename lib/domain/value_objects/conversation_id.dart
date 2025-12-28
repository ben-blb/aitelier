class ConversationId {
  final String value;

  ConversationId(this.value) {
    if (value.isEmpty) {
      throw ArgumentError('ConversationId cannot be empty');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationId && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
