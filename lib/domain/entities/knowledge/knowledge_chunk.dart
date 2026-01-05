import 'package:aitelier/domain/entities/knowledge/chunk_metadata.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/domain/value_objects/chunk_version.dart';

class KnowledgeChunk {
  final ChunkId id;
  final ChunkMetadata metadata;
  final ChunkVersion version;
  final int charStart;
  final int charEnd;
  final DateTime createdAt;

  KnowledgeChunk({
    required this.id,
    required this.metadata,
    required this.version,
    required this.charStart,
    required this.charEnd,
    required this.createdAt,
  });
}
