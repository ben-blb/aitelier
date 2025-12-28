class ConversationPurpose {
  final String value;

  ConversationPurpose(this.value){
    if(value.isEmpty){
      throw ArgumentError('Purpose cannot be empty');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationPurpose && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
