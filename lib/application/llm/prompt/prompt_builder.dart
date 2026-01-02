import 'package:aitelier/domain/entities/llm/llm_message.dart';
import 'package:aitelier/domain/entities/llm/llm_prompt.dart';

class PromptBuilder {
  LLMPrompt build({
    required List<LLMMessage> conversation,
    required String purpose,
  }) {
    return LLMPrompt([
      LLMMessage(
        role: LLMRole.system,
        content: purpose,
      ),
      ...conversation,
    ]);
  }
}
