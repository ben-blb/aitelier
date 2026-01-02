import 'package:aitelier/domain/entities/llm/llm_message.dart';

class LLMPrompt {
  final List<LLMMessage> messages;

  const LLMPrompt(this.messages);
}
