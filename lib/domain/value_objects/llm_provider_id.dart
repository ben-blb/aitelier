class LLMModelId {
  final String value;

  const LLMModelId(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LLMModelId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
