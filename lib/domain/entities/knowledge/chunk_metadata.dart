import 'package:aitelier/domain/entities/knowledge/chunk_source.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

class ChunkMetadata {
  final ProjectId projectId;
  final ChunkSource source;
  final String sourceId;
  final int position;
  final Map<String, String> tags;

  const ChunkMetadata({
    required this.projectId,
    required this.source,
    required this.sourceId,
    required this.position,
    this.tags = const {},
  });
}
