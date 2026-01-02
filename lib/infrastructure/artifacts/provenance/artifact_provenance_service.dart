import 'dart:convert';
import 'dart:io';

class ArtifactProvenanceService {
  final File file;

  ArtifactProvenanceService(Directory root)
      : file = File('${root.path}/artifacts/provenance/artifact_provenance.json');

  Future<void> record({
    required String artifactId,
    required String conversationId,
    required String purpose,
    String? parentArtifactId,
  }) async {
    final data = await _load();

    data['artifacts'].add({
      'artifactId': artifactId,
      'conversationId': conversationId,
      'purpose': purpose,
      'parentArtifactId': parentArtifactId,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    });

    await file.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<Map<String, dynamic>> _load() async {
    if (!await file.exists()) {
      return {'artifacts': []};
    }
    return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  }
}
