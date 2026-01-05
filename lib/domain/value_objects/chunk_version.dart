class ChunkVersion {
  final int value;

  const ChunkVersion(this.value);

  ChunkVersion next() => ChunkVersion(value + 1);

  @override
  String toString() => value.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChunkVersion && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
