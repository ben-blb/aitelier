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
    required Map<String, dynamic> metadata,
    required String content,
    required String artifactId,
    required String version,
    required String conversationId,
    required String fileExtension,
  }) async {
    await writer.writeMetadata(artifactId, metadata);
    await writer.writeContent(
      artifactId: artifactId,
      version: version,
      content: content,
      extension: fileExtension,
    );

    await artifactIndex.upsert(metadata);
    await conversationIndex.link(conversationId, artifactId);
  }

  Future<Map<String, dynamic>> loadMetadata(String artifactId) {
    return reader.readMetadata(artifactId);
  }

  Future<String> loadContent(
    String artifactId,
    String version,
    String extension,
  ) {
    return reader.readContent(
      artifactId: artifactId,
      version: version,
      extension: extension,
    );
  }
}
