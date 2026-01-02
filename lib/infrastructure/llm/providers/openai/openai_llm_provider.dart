import 'package:aitelier/domain/entities/llm/llm_execution_request.dart';
import 'package:aitelier/domain/entities/llm/llm_execution_result.dart';
import 'package:aitelier/domain/entities/llm/llm_stream_chunk.dart';
import 'package:aitelier/infrastructure/llm/llm_provider.dart';

import 'openai_client.dart';
import 'openai_models.dart';

class OpenAILLMProvider implements LLMProvider {
  final OpenAIClient client;

  OpenAILLMProvider(this.client);

  @override
  Future<LLMExecutionResult> execute(
    LLMExecutionRequest request,
  ) async {
    final response = await client.execute(
      OpenAIChatRequest(
        model: request.model.value,
        stream: false,
        messages: request.prompt.messages
            .map(
              (m) => OpenAIChatMessage(
                role: m.role.name,
                content: m.content,
              ),
            )
            .toList(),
      ),
    );

    return LLMExecutionResult(
      response.choices.first.message.content,
    );
  }

  @override
  Stream<LLMStreamChunk> stream( // streamming will be back in avengers doomsday
    LLMExecutionRequest request,
  ) async* {
    final result = await execute(request);
    yield LLMStreamChunk(
      content: result.content,
      isFinal: true,
    );
  }
}
