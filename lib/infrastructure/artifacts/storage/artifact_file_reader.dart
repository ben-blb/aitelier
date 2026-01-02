import 'dart:convert';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class ArtifactFileReader {
  final Directory root;

  ArtifactFileReader(this.root);

  Future<Map<String, dynamic>> readMetadata(ProjectId projectId, String artifactId) async {
    final file =
        File(p.join(root.path, projectId.value, 'artifacts', artifactId, 'metadata.json'));

    final content = await file.readAsString();
    return jsonDecode(content) as Map<String, dynamic>;
  }

  Future<String> readContent({
    required ProjectId projectId,
    required String artifactId,
    required String version,
    required String extension,
  }) async {
    final file = File(
      p.join(root.path, projectId.value, 'artifacts', artifactId, 'content', 'v$version', 'artifact.$extension'),
    );

    return file.readAsString();
  }
}
