import 'dart:convert';
import 'dart:io';

class ConversationIndexService {
  final Directory root;

  ConversationIndexService(this.root);

  File _file(String conversationId) => File(
        '${root.path}/artifacts/conversations/$conversationId.json',
      );

  Future<void> link(String conversationId, String artifactId) async {
    final file = _file(conversationId);

    final data = await _load(conversationId);
    final artifacts = data['artifactIds'] as List<dynamic>;

    if (!artifacts.contains(artifactId)) {
      artifacts.add(artifactId);
    }

    await file.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<Map<String, dynamic>> _load(String conversationId) async {
    final file = _file(conversationId);

    if (!await file.exists()) {
      return {
        'conversationId': conversationId,
        'artifactIds': [],
      };
    }

    return jsonDecode(await file.readAsString())
        as Map<String, dynamic>;
  }
}
