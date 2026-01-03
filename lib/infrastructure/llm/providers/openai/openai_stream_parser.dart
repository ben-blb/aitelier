import 'dart:convert';

Iterable<String> parseOpenAIStream(String chunk) sync* {
  final lines = chunk.split('\n');
  for (final line in lines) {
    if (!line.startsWith('data:')) continue;

    final data = line.substring(5).trim();
    if (data == '[DONE]') return;

    final json = jsonDecode(data);
    final delta = json['choices']?[0]?['delta']?['content'];
    if (delta != null) {
      yield delta as String;
    }
  }
}
