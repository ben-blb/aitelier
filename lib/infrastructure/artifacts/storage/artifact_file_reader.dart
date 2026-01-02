import 'dart:convert';
import 'dart:io';

class ArtifactFileReader {
  final Directory root;

  ArtifactFileReader(this.root);

  Future<Map<String, dynamic>> readMetadata(String artifactId) async {
    final file =
        File('${root.path}/artifacts/$artifactId/metadata.json');

    final content = await file.readAsString();
    return jsonDecode(content) as Map<String, dynamic>;
  }

  Future<String> readContent({
    required String artifactId,
    required String version,
    required String extension,
  }) async {
    final file = File(
      '${root.path}/artifacts/$artifactId/content/v$version/artifact.$extension',
    );

    return file.readAsString();
  }
}
