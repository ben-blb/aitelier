class LLMProviderId {
  final String value;

  const LLMProviderId(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LLMProviderId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
