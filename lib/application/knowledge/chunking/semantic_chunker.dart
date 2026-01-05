import 'package:aitelier/application/knowledge/chunking/chunker.dart';
import 'package:aitelier/domain/entities/knowledge/chunk_metadata.dart';
import 'package:aitelier/domain/entities/knowledge/chunk_source.dart';
import 'package:aitelier/domain/entities/knowledge/knowledge_chunk.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/domain/value_objects/chunk_version.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

class SemanticChunker {
  final Chunker splitter;

  SemanticChunker(this.splitter);

  List<KnowledgeChunk> chunk({
    required ProjectId projectId,
    required ChunkSource source,
    required String sourceId,
    required String text,
    required ChunkVersion version,
  }) {
    final slices = splitter.split(text);

    return slices.asMap().entries.map((entry) {
      final index = entry.key;
      final slice = entry.value;

      return KnowledgeChunk(
        id: ChunkId.generate(),
        metadata: ChunkMetadata(
          projectId: projectId,
          source: source,
          sourceId: sourceId,
          position: index,
        ),
        version: version,
        charStart: slice.start,
        charEnd: slice.end,
        createdAt: DateTime.now(),
      );
    }).toList();
  }
}
