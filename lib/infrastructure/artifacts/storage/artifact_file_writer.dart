import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:aitelier/domain/value_objects/project_id.dart';

class ArtifactFileWriter {
  final Directory root;

  ArtifactFileWriter(this.root);

  Directory _artifactDir(ProjectId projectId, String id) =>
      Directory(p.join(root.path, projectId.value, 'artifacts', id));

  Future<void> writeMetadata(
    ProjectId projectId,
    String artifactId,
    Map<String, dynamic> metadata,
  ) async {
    final dir = _artifactDir(projectId, artifactId);
    await dir.create(recursive: true);

    final file = File('${dir.path}/metadata.json');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(metadata),
    );
  }

  Future<void> writeContent({
    required ProjectId projectId,
    required String artifactId,
    required String version,
    required String content,
    required String extension,
  }) async {
    final dir = Directory(
      p.join(root.path, projectId.value, 'artifacts', artifactId, 'content', 'v$version'),
    );

    await dir.create(recursive: true);

    final file = File(p.join(dir.path, 'artifact.$extension'));
    await file.writeAsString(content);
  }
}
