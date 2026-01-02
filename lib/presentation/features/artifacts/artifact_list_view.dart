import 'package:aitelier/application/use_cases/dependencies.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/artifacts/models/artifact_summary.dart';
import 'package:aitelier/presentation/features/artifacts/artifact_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtifactListView extends ConsumerWidget {
  final ProjectId projectId;
  final ConversationId conversationId;
  ArtifactListView({super.key, required this.conversationId, required this.projectId});

  final listArtifactsProvider =
      FutureProvider.family<List<ArtifactSummary>, ProjectId>((ref, projectId) {
    return ref.read(listArtifactsUseCaseProvider).call(projectId);
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(listArtifactsProvider(projectId));

    return Scaffold(
      appBar: AppBar(title: Text('Artifacts ${conversationId.value}')),
      body: future.when(
        data: (artifacts) => ListView.builder(
          itemCount: artifacts.length,
          itemBuilder: (_, i) {
            final a = artifacts[i];
            return ListTile(
              title: Text(a.title),
              subtitle: Text('${a.type} • v${a.currentVersion}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ArtifactDetailView(artifact: a, projectId: projectId,),
                  ),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
