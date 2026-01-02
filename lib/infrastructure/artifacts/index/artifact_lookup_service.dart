import 'dart:convert';
import 'dart:io';

import '../models/artifact_summary.dart';

class ArtifactLookupService {
  final Directory root;

  ArtifactLookupService(this.root);

  File get _indexFile => File('${root.path}/artifacts/index.json');

  Future<List<ArtifactSummary>> listAll() async {
    if (!await _indexFile.exists()) {
      return [];
    }

    final json =
        jsonDecode(await _indexFile.readAsString()) as Map<String, dynamic>;

    final artifacts = json['artifacts'] as List<dynamic>;

    return artifacts
        .map((a) => ArtifactSummary.fromJson(a))
        .toList();
  }

  Future<List<ArtifactSummary>> findByTag(String tag) async {
    final all = await listAll();
    return all.where((a) => a.tags.contains(tag)).toList();
  }

  Future<List<ArtifactSummary>> findByType(String type) async {
    final all = await listAll();
    return all.where((a) => a.type == type).toList();
  }

  Future<List<ArtifactSummary>> findByConversation(
    String conversationId,
  ) async {
    final file = File(
      '${root.path}/artifacts/conversations/$conversationId.json',
    );

    if (!await file.exists()) {
      return [];
    }

    final data =
        jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    final ids = List<String>.from(data['artifactIds'] ?? []);

    final all = await listAll();
    return all.where((a) => ids.contains(a.id)).toList();
  }
}
