import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/core/utils/logger.dart';
import 'package:aitelier/domain/entities/knowledge/summary.dart';
import 'package:aitelier/domain/entities/llm/llm_execution_request.dart';
import 'package:aitelier/domain/entities/llm/llm_message.dart';
import 'package:aitelier/domain/entities/llm/llm_prompt.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:aitelier/infrastructure/llm/llm_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class IncrementalSummaryStep implements PipelineStepHandler {
  final Ref ref;
  static const _uuid = Uuid();

  IncrementalSummaryStep(this.ref);

  @override
  String get stepId => 'post.incremental_summary';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    appLogger.i('[IncrementalSummaryStep] Starting');

    final artifacts = context.metadata['artifacts'];
    if (artifacts is! List || artifacts.isEmpty) {
      appLogger.d('[IncrementalSummaryStep] No artifacts, skipping');
      return context;
    }

    final summaryRepo =
        ref.read(summaryRepositoryProvider);
    final llm =
        await ref.read(llmRepositoryProvider.future);

    final scope = SummaryScope.conversation;

    final scopeId = context.conversationId.value;

    final existing =
        await summaryRepo.findByScope(scope, scopeId);

    final artifactText = artifacts
        .map((a) => a['content'])
        .join('\n');

    final prompt = '''
You are maintaining an incremental summary.

Current summary:
${existing?.content ?? '(none)'}

New information:
$artifactText

Update the summary concisely.
''';

  final request = LLMExecutionRequest(
    prompt: LLMPrompt([
      LLMMessage(
        role: LLMRole.system,
        content: prompt,
      ),
    ]),
    model: const LLMModelId('gpt-4.1-mini'),
    stream: false,
  );

  final result = await llm.execute(request);

    final updated = Summary(
      id: existing?.id ?? _uuid.v4(),
      scope: scope,
      scopeId: scopeId,
      content: result.content,
      version: (existing?.version ?? 0) + 1,
      updatedAt: DateTime.now(),
    );

    await summaryRepo.save(updated);

    appLogger.i(
      '[IncrementalSummaryStep] Summary updated '
      '(scope=$scope scopeId=$scopeId version=${updated.version})',
    );

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['summary'] = {
        'scope': scope.name,
        'content': updated.content,
        'version': updated.version,
      };

    return context.copyWith(metadata: updatedMetadata);
  }
}
