import 'dart:convert';
import 'dart:io';

class LineageIndexService {
  final Directory root;

  LineageIndexService(this.root);

  Future<void> linkChild({
    required String parentId,
    required String childId,
  }) async {
    final file =
        File('${root.path}/artifacts/provenance/lineage/$parentId.json');

    final data = await _load(file, parentId);
    final children = data['children'] as List<dynamic>;

    if (!children.contains(childId)) {
      children.add(childId);
    }

    await file.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<Map<String, dynamic>> _load(File file, String parentId) async {
    if (!await file.exists()) {
      return {
        'artifactId': parentId,
        'children': [],
      };
    }
    return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  }
}
