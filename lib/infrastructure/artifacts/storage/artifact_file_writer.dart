import 'dart:convert';
import 'dart:io';

class ArtifactFileWriter {
  final Directory root;

  ArtifactFileWriter(this.root);

  Directory _artifactDir(String id) =>
      Directory('${root.path}/artifacts/$id');

  Future<void> writeMetadata(
    String artifactId,
    Map<String, dynamic> metadata,
  ) async {
    final dir = _artifactDir(artifactId);
    await dir.create(recursive: true);

    final file = File('${dir.path}/metadata.json');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(metadata),
    );
  }

  Future<void> writeContent({
    required String artifactId,
    required String version,
    required String content,
    required String extension,
  }) async {
    final dir = Directory(
      '${root.path}/artifacts/$artifactId/content/v$version',
    );

    await dir.create(recursive: true);

    final file = File('${dir.path}/artifact.$extension');
    await file.writeAsString(content);
  }
}
