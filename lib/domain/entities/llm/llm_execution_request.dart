import 'package:aitelier/domain/entities/llm/llm_prompt.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';

class LLMExecutionRequest {
  final LLMPrompt prompt;
  final LLMModelId model;
  final bool stream;

  const LLMExecutionRequest({
    required this.prompt,
    required this.model,
    required this.stream,
  });
}
