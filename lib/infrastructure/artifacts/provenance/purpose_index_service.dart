import 'dart:convert';
import 'dart:io';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';

class PurposeIndexService {
  final Directory root;

  PurposeIndexService(this.root);

  Future<void> link(String purpose, ProjectId projectId, String artifactId) async {
    final hash = sha1.convert(purpose.codeUnits).toString();
    final file = File(p.join(root.path, projectId.value, 'artifacts', 'provenance', 'purposes', '$hash.json'));

    final data = await _load(file, purpose);
    final artifacts = data['artifactIds'] as List<dynamic>;

    if (!artifacts.contains(artifactId)) {
      artifacts.add(artifactId);
    }

    await file.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  Future<Map<String, dynamic>> _load(File file, String purpose) async {
    if (!await file.exists()) {
      return {
        'purpose': purpose,
        'artifactIds': [],
      };
    }
    return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  }
}
