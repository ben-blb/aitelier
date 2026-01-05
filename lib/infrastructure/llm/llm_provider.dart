import 'package:aitelier/domain/entities/llm/llm_execution_request.dart';
import 'package:aitelier/domain/entities/llm/llm_execution_result.dart';
import 'package:aitelier/domain/entities/llm/llm_stream_chunk.dart';

abstract class LLMProvider {
  Stream<LLMStreamChunk> stream(
    LLMExecutionRequest request,
  );

  Future<LLMExecutionResult> execute(
    LLMExecutionRequest request,
  );

  Future<List<double>> createEmbedding({
    required String input,
    required String model,
  });
}
