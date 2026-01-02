import 'package:aitelier/domain/repositories/llm_repository.dart';
import 'package:aitelier/infrastructure/llm/llm_repository_impl.dart';
import 'package:aitelier/infrastructure/llm/providers/openai/openai_client.dart';
import 'package:aitelier/infrastructure/llm/providers/openai/openai_llm_provider.dart';
import 'package:aitelier/infrastructure/network/http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../dependencies.dart';

final httpRawClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient(ref.read(httpRawClientProvider));
});

final openAIClientProvider = FutureProvider<OpenAIClient>((ref) async {
  final secretStorage = ref.read(secretStorageProvider);
  final apiKey = await secretStorage.read(key: 'openai_api_key');

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('OpenAI API key not found');
  }

  return OpenAIClient(
    http: ref.read(httpClientProvider),
    apiKey: apiKey,
  );
});

final llmRepositoryProvider = FutureProvider<LLMRepository>((ref) async {
  final client = await ref.watch(openAIClientProvider.future);

  return LLMRepositoryImpl(
    OpenAILLMProvider(client),
  );
});
