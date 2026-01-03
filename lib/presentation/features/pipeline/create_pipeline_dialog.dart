import 'package:aitelier/domain/entities/pipeline/pipeline.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:aitelier/presentation/providers/pipeline_ui_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePipelineDialog extends ConsumerStatefulWidget {
  const CreatePipelineDialog({super.key});

  @override
  ConsumerState<CreatePipelineDialog> createState() =>
      _CreatePipelineDialogState();
}

class _CreatePipelineDialogState
    extends ConsumerState<CreatePipelineDialog> {
  final _idCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _purposeCtrl = TextEditingController();
  final _stepsCtrl = TextEditingController();

  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Pipeline'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _idCtrl,
              decoration: const InputDecoration(labelText: 'Pipeline ID'),
            ),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _purposeCtrl,
              decoration:
                  const InputDecoration(labelText: 'Purpose (e.g. debugging)'),
            ),
            TextField(
              controller: _stepsCtrl,
              decoration: const InputDecoration(
                labelText: 'Step IDs (comma separated)',
                hintText:
                    'post.output_normalization,post.chunking,post.artifact_enrichment',
              ),
            ),
            SwitchListTile(
              title: const Text('Enabled'),
              value: enabled,
              onChanged: (v) => setState(() => enabled = v),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final pipeline = Pipeline(
              id: _idCtrl.text.trim(),
              name: _nameCtrl.text.trim(),
              enabled: enabled,
              stepIds: _stepsCtrl.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList(),
            );

            await ref.read(pipelineRepositoryProvider).save(pipeline);

            await ref
                .read(pipelinePurposeRepositoryProvider)
                .assignPipeline(
                  _purposeCtrl.text.trim(),
                  pipeline.id,
                );

            ref.invalidate(pipelinesProvider);

            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
