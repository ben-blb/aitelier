import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

class PurposeIndexService {
  final Directory root;

  PurposeIndexService(this.root);

  Future<void> link(String purpose, String artifactId) async {
    final hash = sha1.convert(purpose.codeUnits).toString();
    final file = File('${root.path}/artifacts/provenance/purposes/$hash.json');

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
