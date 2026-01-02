import 'dart:convert';
import '../../../network/http_client.dart';
import 'openai_models.dart';

class OpenAIClient {
  final HttpClient http;
  final String apiKey;

  OpenAIClient({
    required this.http,
    required this.apiKey,
  });

  Future<OpenAIChatResponse> execute(
    OpenAIChatRequest request,
  ) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: request.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return OpenAIChatResponse.fromJson(
      jsonDecode(response.body),
    );
  }
}
