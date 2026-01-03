import 'dart:convert';
import 'dart:io';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:path/path.dart' as p;

class ConversationIndexService {
  final Directory root;

  ConversationIndexService(this.root);

  File _file(ProjectId projectId, ConversationId conversationId) => File(
    p.join(root.path, projectId.value, 'artifacts', 'conversations', '${conversationId.value}.json'),
      );

  Future<void> link(ProjectId projectId, ConversationId conversationId, String artifactId) async {
    final file = _file(projectId, conversationId);

    final data = await _load(projectId, conversationId);
    final artifacts = data['artifactIds'] as List<dynamic>;

    if (!artifacts.contains(artifactId)) {
      artifacts.add(artifactId);
    }

    await file.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<Map<String, dynamic>> _load(
    ProjectId projectId,
    ConversationId conversationId,
  ) async {
    final file = _file(projectId, conversationId);

    final fallback = {
      'conversationId': conversationId.value,
      'artifactIds': <String>[],
    };

    if (!await file.exists()) {
      return fallback;
    }

    try {
      final content = await file.readAsString();
      final decoded = jsonDecode(content);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return fallback;
    } catch (_) {
      return fallback;
    }
  }

}
