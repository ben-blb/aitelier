class EmbeddingVersion {
  final int value;

  const EmbeddingVersion(this.value);

  EmbeddingVersion next() => EmbeddingVersion(value + 1);

  @override
  String toString() => value.toString();
}
