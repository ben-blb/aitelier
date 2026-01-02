import 'dart:convert';
import 'dart:io';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:path/path.dart' as p;

class ArtifactIndexService {
  final Directory root;
  
  File _indexFile(ProjectId projectId) =>
      File(p.join(root.path, projectId.value, 'artifacts','index.json'));

  ArtifactIndexService(this.root);

  Future<void> upsert(Map<String, dynamic> metadata, ProjectId projectId) async {
    final index = await _load(projectId);

    final artifacts = index['artifacts'] as List<dynamic>;
    artifacts.removeWhere((a) => a['id'] == metadata['id']);

    artifacts.add({
      'id': metadata['id'],
      'type': metadata['type'],
      'title': metadata['title'],
      'currentVersion': metadata['currentVersion'],
      'tags': metadata['tags'],
    });

    await _indexFile(projectId).create(recursive: true);
    await _indexFile(projectId).writeAsString(
      const JsonEncoder.withIndent('  ').convert(index),
    );
  }

  Future<Map<String, dynamic>> _load(ProjectId projectId) async {
    if (!await _indexFile(projectId).exists()) {
      return {'artifacts': []};
    }

    return jsonDecode(await _indexFile(projectId).readAsString())
        as Map<String, dynamic>;
  }
}
