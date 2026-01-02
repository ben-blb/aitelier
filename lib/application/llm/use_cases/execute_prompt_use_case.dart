import 'package:aitelier/domain/entities/llm/llm_execution_request.dart';
import 'package:aitelier/domain/entities/llm/llm_execution_result.dart';
import 'package:aitelier/domain/entities/llm/llm_prompt.dart';
import 'package:aitelier/domain/entities/llm/llm_stream_chunk.dart';
import 'package:aitelier/domain/repositories/llm_repository.dart';
import 'package:aitelier/domain/value_objects/llm_provider_id.dart';

class ExecutePromptUseCase {
  final LLMRepository repository;

  ExecutePromptUseCase(this.repository);

  Stream<LLMStreamChunk> stream({
    required LLMPrompt prompt,
    required LLMModelId model,
  }) {
    return repository.executeStream(
      LLMExecutionRequest(
        prompt: prompt,
        model: model,
        stream: true,
      ),
    );
  }

  Future<LLMExecutionResult> run({
    required LLMPrompt prompt,
    required LLMModelId model,
  }) {
    return repository.execute(
      LLMExecutionRequest(
        prompt: prompt,
        model: model,
        stream: false,
      ),
    );
  }
}
