class OpenAIChatMessage {
  final String role;
  final String content;

  const OpenAIChatMessage({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}

class OpenAIChatRequest {
  final String model;
  final List<OpenAIChatMessage> messages;
  final bool stream;

  const OpenAIChatRequest({
    required this.model,
    required this.messages,
    required this.stream,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'messages': messages.map((m) => m.toJson()).toList(),
      'stream': stream,
    };
  }
}

class OpenAIChoiceMessage {
  final String content;

  const OpenAIChoiceMessage(this.content);

  factory OpenAIChoiceMessage.fromJson(Map<String, dynamic> json) {
    return OpenAIChoiceMessage(
      json['content'] as String,
    );
  }
}

class OpenAIChoice {
  final OpenAIChoiceMessage message;

  const OpenAIChoice(this.message);

  factory OpenAIChoice.fromJson(Map<String, dynamic> json) {
    return OpenAIChoice(
      OpenAIChoiceMessage.fromJson(json['message']),
    );
  }
}

class OpenAIChatResponse {
  final List<OpenAIChoice> choices;

  const OpenAIChatResponse(this.choices);

  factory OpenAIChatResponse.fromJson(Map<String, dynamic> json) {
    return OpenAIChatResponse(
      (json['choices'] as List)
          .map((c) => OpenAIChoice.fromJson(c))
          .toList(),
    );
  }
}
