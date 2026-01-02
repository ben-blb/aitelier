import 'package:aitelier/domain/entities/llm/llm_message.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';

import '../llm/prompt/prompt_builder.dart';
import '../llm/use_cases/execute_prompt_use_case.dart';

class ConversationPromptExecutor {
  final PromptBuilder promptBuilder;
  final ExecutePromptUseCase executePrompt;

  ConversationPromptExecutor({
    required this.promptBuilder,
    required this.executePrompt,
  });

  Stream<String> streamResponse({
    required List<LLMMessage> conversation,
    required String purpose,
    required LLMModelId model,
  }) {
    final prompt = promptBuilder.build(
      conversation: conversation,
      purpose: purpose,
    );

    return executePrompt
        .stream(
          prompt: prompt,
          model: model,
        )
        .map((chunk) => chunk.content);
  }
}
