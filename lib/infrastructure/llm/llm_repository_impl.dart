import 'package:aitelier/domain/entities/llm/llm_execution_request.dart';
import 'package:aitelier/domain/entities/llm/llm_execution_result.dart';
import 'package:aitelier/domain/entities/llm/llm_stream_chunk.dart';
import 'package:aitelier/domain/repositories/llm_repository.dart';
import 'package:aitelier/infrastructure/llm/llm_provider.dart';

class LLMRepositoryImpl implements LLMRepository {
  final LLMProvider provider;

  LLMRepositoryImpl(this.provider);

  @override
  Stream<LLMStreamChunk> executeStream(
    LLMExecutionRequest request,
  ) {
    return provider.stream(request);
  }

  @override
  Future<LLMExecutionResult> execute(
    LLMExecutionRequest request,
  ) {
    return provider.execute(request);
  }
}
