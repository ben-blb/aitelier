import 'package:aitelier/application/dependencies.dart';
import 'package:aitelier/application/use_cases/dependencies.dart';
import 'package:aitelier/domain/entities/llm/llm_message.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/conversations/models/conversation_message_record.dart';
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

    final userMessage = ConversationMessageRecord(
      role: 'user',
      content: text,
      timestamp: DateTime.now(),
    );

    state = AsyncData([...current, userMessage]);

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
      conversation: [...current, userMessage].map(_toLLM).toList(),
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

    await _appendMessage.execute(
      projectId: arg.projectId,
      conversationId: arg.conversationId,
      message: assistantMessage.copyWith(
        content: assistantBuffer.toString(),
      ),
    );
  }
}
