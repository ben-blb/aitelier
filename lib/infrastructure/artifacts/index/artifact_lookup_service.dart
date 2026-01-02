import 'dart:convert';
import 'dart:io';
import 'package:aitelier/core/utils/logger.dart';
import 'package:path/path.dart' as p;

import 'package:aitelier/domain/value_objects/project_id.dart';

import '../models/artifact_summary.dart';

class ArtifactLookupService {
  final Directory root;

  ArtifactLookupService(this.root);

  File _indexFile(ProjectId projectId) => File(p.join(root.path, projectId.value, 'artifacts','index.json'));

  Future<List<ArtifactSummary>> listAll(ProjectId projectId) async {
    appLogger.d('Got index file ${_indexFile(projectId)}');
    if (!await _indexFile(projectId).exists()) {
      appLogger.w('Index file not found');
      return [];
    }

    final json =
        jsonDecode(await _indexFile(projectId).readAsString()) as Map<String, dynamic>;

    final artifacts = json['artifacts'] as List<dynamic>;

    appLogger.i('Found ${artifacts.length} artifacts');

    return artifacts
        .map((a) => ArtifactSummary.fromJson(a))
        .toList();
  }

  Future<List<ArtifactSummary>> findByTag(ProjectId projectId, String tag) async {
    final all = await listAll(projectId);
    return all.where((a) => a.tags.contains(tag)).toList();
  }

  Future<List<ArtifactSummary>> findByType(ProjectId projectId, String type) async {
    final all = await listAll(projectId);
    return all.where((a) => a.type == type).toList();
  }

  Future<List<ArtifactSummary>> findByConversation(
    String conversationId,
    ProjectId projectId,
  ) async {
    final file = File(
      p.join(root.path, projectId.value, 'artifacts', 'conversations','$conversationId.json'),
    );

    if (!await file.exists()) {
      return [];
    }

    final data =
        jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    final ids = List<String>.from(data['artifactIds'] ?? []);

    final all = await listAll(projectId);
    return all.where((a) => ids.contains(a.id)).toList();
  }
}
