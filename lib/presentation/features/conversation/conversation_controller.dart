import 'package:aitelier/application/dependencies.dart';
import 'package:aitelier/application/use_cases/dependencies.dart';
import 'package:aitelier/core/pipeline/pipeline_executor.dart';
import 'package:aitelier/core/pipeline/pipeline_providers.dart';
import 'package:aitelier/domain/entities/llm/llm_message.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/artifacts/models/artifact_processing_input.dart';
import 'package:aitelier/infrastructure/conversations/models/conversation_message_record.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


typedef ConversationKey = ({ProjectId projectId, ConversationId conversationId});

LLMMessage _toLLM(ConversationMessageRecord r) {
  return LLMMessage(
    role: r.role == 'user' ? LLMRole.user : LLMRole.assistant,
    content: r.content,
  );
}

final conversationScreenProvider =
    AsyncNotifierProvider.family<
        ConversationController,
        List<ConversationMessageRecord>,
        ConversationKey>(
  ConversationController.new,
);

class ConversationController
    extends FamilyAsyncNotifier<List<ConversationMessageRecord>, ConversationKey> {
  late final _getMessages = ref.read(getConversationMessagesUseCaseProvider);
  late final _appendMessage = ref.read(appendMessageUseCaseProvider);

  @override
  Future<List<ConversationMessageRecord>> build(ConversationKey arg) async {
    return _getMessages.execute(
      projectId: arg.projectId,
      conversationId: arg.conversationId,
    );
  }

  Future<void> sendMessage(String text) async {
    final executor = await ref.read(conversationPromptExecutorProvider.future);
    final current = state.value;
    if (current == null) return;

    final registry = ref.read(pipelineRegistryProvider);

    final pipelineExecutor = PipelineExecutor(registry);

    final context = PipelineContext(input: text);
    
    final pipelineResult = await pipelineExecutor.execute(
      Pipeline(
        id: 'test-123',
        name: 'preprocessing',
        stepIds: [
          'pre.context_retrieval',
          'pre.intent_classification',
          'pre.entity_extraction',
          'pre.semantic_search',
          'post.output_normalization',
          'post.chunking',
          'post.artifact_enrichment'],
        enabled: true
      ),
      context,
    );

    final pipelineMessage = ConversationMessageRecord(
      role: 'pipeline',
      content: pipelineResult.metadata.toString(),
      timestamp: DateTime.now(),
    );

    final userMessage = ConversationMessageRecord(
      role: 'user',
      content: text,
      timestamp: DateTime.now(),
    );

    state = AsyncData([...current, pipelineMessage, userMessage]);

    await _appendMessage.execute(
      projectId: arg.projectId,
      conversationId: arg.conversationId,
      message: pipelineMessage,
    );

    await _appendMessage.execute(
      projectId: arg.projectId,
      conversationId: arg.conversationId,
      message: userMessage,
    );

    final assistantBuffer = StringBuffer();

    final assistantMessage = ConversationMessageRecord(
      role: 'assistant',
      content: '',
      timestamp: DateTime.now(),
    );

    state = AsyncData([...state.value!, assistantMessage]);

    await for (final chunk in executor.streamResponse(
      conversation: [...current, pipelineMessage, userMessage].map(_toLLM).toList(),
      purpose: 'general',
      model: const LLMModelId('gpt-4o-mini'),
    )) {
      assistantBuffer.write(chunk);

      final updatedAssistant = assistantMessage.copyWith(
        content: assistantBuffer.toString(),
      );

      state = AsyncData([
        ...state.value!.sublist(0, state.value!.length - 1),
        updatedAssistant,
      ]);
    }

    final processor = ref.read(genericArtifactProcessorProvider);

    await processor.process(
      ArtifactProcessingInput(
        projectId: arg.projectId,
        conversationId: arg.conversationId,
        purpose: 'general',
        rawOutput: assistantBuffer.toString(),
        contentTypeHint: 'text',
        preferredTitle: 'LLM Output',
      ),
    );

    await _appendMessage.execute(
      projectId: arg.projectId,
      conversationId: arg.conversationId,
      message: assistantMessage.copyWith(
        content: assistantBuffer.toString(),
      ),
    );
  }
}
