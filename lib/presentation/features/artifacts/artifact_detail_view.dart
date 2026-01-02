import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/artifacts/models/artifact_summary.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ArtifactDetailView extends ConsumerWidget {
  final ArtifactSummary artifact;
  final ProjectId projectId;

  ArtifactDetailView({
    super.key,
    required this.artifact,
    required this.projectId,
  });

  final artifactContentProvider =
    FutureProvider.family<String, ArtifactContentKey>((ref, key) {
    final storage = ref.read(artifactStorageServiceProvider);

    return storage.loadContent(
      key.projectId,
      key.artifactId,
      key.version,
      key.extension,
    );
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ArtifactContentKey(
      projectId: projectId,
      artifactId: artifact.id,
      version: artifact.currentVersion,
      extension: _extensionForType(artifact.type),
    );

    final future = ref.watch(artifactContentProvider(key));

    return Scaffold(
      appBar: AppBar(title: Text(artifact.title)),
      body: future.when(
        data: (content) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SelectableText(content),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  String _extensionForType(String type) {
    switch (type) {
      case 'markdown':
        return 'md';
      case 'json':
        return 'json';
      default:
        return 'txt';
    }
  }
}


class ArtifactContentKey {
  final ProjectId projectId;
  final String artifactId;
  final String version;
  final String extension;

  const ArtifactContentKey({
    required this.projectId,
    required this.artifactId,
    required this.version,
    required this.extension,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtifactContentKey &&
          projectId == other.projectId &&
          artifactId == other.artifactId &&
          version == other.version &&
          extension == other.extension;

  @override
  int get hashCode =>
      Object.hash(projectId, artifactId, version, extension);
}
