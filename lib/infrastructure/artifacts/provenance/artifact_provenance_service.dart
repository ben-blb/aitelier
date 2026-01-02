import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:aitelier/domain/value_objects/project_id.dart';

class ArtifactProvenanceService {
  final Directory root;
  
  File _file(ProjectId projectId) =>
      File(p.join(root.path, projectId.value, 'artifacts', 'provenance', 'artifact_provenance.json'));

  ArtifactProvenanceService(this.root);

  Future<void> record({
    required String artifactId,
    required String conversationId,
    required String purpose,
    required ProjectId projectId,
    String? parentArtifactId,
  }) async {
    final data = await _load(projectId);

    data['artifacts'].add({
      'artifactId': artifactId,
      'conversationId': conversationId,
      'purpose': purpose,
      'parentArtifactId': parentArtifactId,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    });

    await _file(projectId).create(recursive: true);
    await _file(projectId).writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<Map<String, dynamic>> _load(ProjectId projectId) async {
    if (!await _file(projectId).exists()) {
      return {'artifacts': []};
    }
    return jsonDecode(await _file(projectId).readAsString()) as Map<String, dynamic>;
  }
}
