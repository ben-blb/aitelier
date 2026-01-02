import 'dart:convert';
import 'dart:io';

class ArtifactIndexService {
  final File indexFile;

  ArtifactIndexService(Directory root)
      : indexFile = File('${root.path}/artifacts/index.json');

  Future<void> upsert(Map<String, dynamic> metadata) async {
    final index = await _load();

    final artifacts = index['artifacts'] as List<dynamic>;
    artifacts.removeWhere((a) => a['id'] == metadata['id']);

    artifacts.add({
      'id': metadata['id'],
      'type': metadata['type'],
      'title': metadata['title'],
      'currentVersion': metadata['currentVersion'],
      'tags': metadata['tags'],
    });

    await indexFile.create(recursive: true);
    await indexFile.writeAsString(
      const JsonEncoder.withIndent('  ').convert(index),
    );
  }

  Future<Map<String, dynamic>> _load() async {
    if (!await indexFile.exists()) {
      return {'artifacts': []};
    }

    return jsonDecode(await indexFile.readAsString())
        as Map<String, dynamic>;
  }
}
