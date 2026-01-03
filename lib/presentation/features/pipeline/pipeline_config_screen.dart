import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:aitelier/presentation/features/pipeline/create_pipeline_dialog.dart';
import 'package:aitelier/presentation/providers/pipeline_ui_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PipelineConfigScreen extends ConsumerWidget {
  const PipelineConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipelinesAsync = ref.watch(pipelinesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pipelines')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const CreatePipelineDialog(),
          );
        },
      ),
      body: pipelinesAsync.when(
        data: (pipelines) => ListView.builder(
          itemCount: pipelines.length,
          itemBuilder: (_, i) {
            final pipeline = pipelines[i];

            return SwitchListTile(
              title: Text(pipeline.name),
              subtitle: Text(pipeline.id),
              value: pipeline.enabled,
              onChanged: (enabled) async {
                await ref
                    .read(pipelineRepositoryProvider)
                    .save(
                      pipeline.copyWith(enabled: enabled),
                    );
                ref.invalidate(pipelinesProvider);
              },
            );
          },
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
