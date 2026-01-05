import 'package:aitelier/domain/entities/llm/llm_execution_request.dart';
import 'package:aitelier/domain/entities/llm/llm_execution_result.dart';
import 'package:aitelier/domain/entities/llm/llm_stream_chunk.dart';
import 'package:aitelier/infrastructure/llm/llm_provider.dart';
import 'package:aitelier/infrastructure/llm/providers/openai/openai_stream_parser.dart';

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
  Stream<LLMStreamChunk> stream(
    LLMExecutionRequest request,
  ) async* {
    final openAIRequest = OpenAIChatRequest(
      model: request.model.value,
      stream: true,
      messages: request.prompt.messages
          .map(
            (m) => OpenAIChatMessage(
              role: m.role.name,
              content: m.content,
            ),
          )
          .toList(),
    );

    await for (final rawChunk
        in client.streamChat(openAIRequest)) {
      for (final token in parseOpenAIStream(rawChunk)) {
        yield LLMStreamChunk(
          content: token,
          isFinal: false,
        );
      }
    }

    yield const LLMStreamChunk(
      content: '',
      isFinal: true,
    );
  }

  @override
  Future<List<double>> createEmbedding({
    required String input,
    required String model,
  }) async {
    final response = await client.createEmbedding(
      model: model,
      input: input,
    );

    return response.data.first.embedding;
  }
}
