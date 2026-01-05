import 'package:uuid/uuid.dart';

class ChunkId {
  final String value;

  const ChunkId._(this.value);

  factory ChunkId.generate() {
    return ChunkId._(const Uuid().v4());
  }

  factory ChunkId.fromString(String value) {
    return ChunkId._(value);
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChunkId && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
