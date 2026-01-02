import 'dart:async';
import 'package:aitelier/application/dependencies.dart';
import 'package:aitelier/domain/entities/llm/llm_message.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationScreenNotifier
    extends StateNotifier<AsyncValue<List<LLMMessage>>> {
  final Ref ref;
  final ConversationId conversationId;
  final ProjectId projectId;

  ConversationScreenNotifier(
    this.ref, {
    required this.conversationId,
    required this.projectId,
  }) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.data([]);
  }

  Future<void> sendMessage(String text) async {
    final current = state.value ?? [];

    final updated = [
      ...current,
      LLMMessage(role: LLMRole.user, content: text),
    ];

    state = AsyncValue.data(updated);

    final executor = await ref.read(conversationPromptExecutorProvider.future);

    final buffer = StringBuffer();

    state = AsyncValue.data([
      ...updated,
      const LLMMessage(role: LLMRole.assistant, content: ''),
    ]);

    await for (final chunk in executor.streamResponse(
      conversation: updated,
      purpose: 'general',
      model: const LLMModelId('gpt-4o-mini'),
    )) {
      buffer.write(chunk);

      state = AsyncValue.data([
        ...updated,
        LLMMessage(
          role: LLMRole.assistant,
          content: buffer.toString(),
        ),
      ]);
    }
  }
}
