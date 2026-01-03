
import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class EntityExtractionStep implements PipelineStepHandler {
  @override
  String get stepId => 'pre.entity_extraction';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    final text = context.input;

    final entities = <String>[];

    final classRegex = RegExp(r'class\s+(\w+)');
    final fileRegex = RegExp(r'([\w\/]+\.dart)');
    final tableRegex = RegExp(r'table\s+(\w+)', caseSensitive: false);

    for (final m in classRegex.allMatches(text)) {
      entities.add('class:${m.group(1)}');
    }

    for (final m in fileRegex.allMatches(text)) {
      entities.add('file:${m.group(1)}');
    }

    for (final m in tableRegex.allMatches(text)) {
      entities.add('table:${m.group(1)}');
    }

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['entities'] = entities;

    return context.copyWith(metadata: updatedMetadata);
  }
}
