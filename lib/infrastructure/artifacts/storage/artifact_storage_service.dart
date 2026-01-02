import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

import 'artifact_file_reader.dart';
import 'artifact_file_writer.dart';
import '../index/artifact_index_service.dart';
import '../index/conversation_index_service.dart';

class ArtifactStorageService {
  final ArtifactFileWriter writer;
  final ArtifactFileReader reader;
  final ArtifactIndexService artifactIndex;
  final ConversationIndexService conversationIndex;

  ArtifactStorageService({
    required this.writer,
    required this.reader,
    required this.artifactIndex,
    required this.conversationIndex,
  });

  Future<void> saveArtifact({
    required ProjectId projectId,
    required Map<String, dynamic> metadata,
    required String content,
    required String artifactId,
    required String version,
    required ConversationId conversationId,
    required String fileExtension,
  }) async {
    await writer.writeMetadata(projectId, artifactId, metadata);
    await writer.writeContent(
      projectId: projectId,
      artifactId: artifactId,
      version: version,
      content: content,
      extension: fileExtension,
    );

    await artifactIndex.upsert(metadata, projectId);
    await conversationIndex.link(projectId, conversationId, artifactId);
  }

  Future<Map<String, dynamic>> loadMetadata(ProjectId projectId, String artifactId) {
    return reader.readMetadata(projectId, artifactId);
  }

  Future<String> loadContent(
    ProjectId projectId,
    String artifactId,
    String version,
    String extension,
  ) {
    return reader.readContent(
      projectId: projectId,
      artifactId: artifactId,
      version: version,
      extension: extension,
    );
  }
}
