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

  OpenAIChatRequest copyWith({bool? stream}) {
    return OpenAIChatRequest(
      model: model,
      messages: messages,
      stream: stream ?? this.stream,
    );
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

class OpenAIEmbeddingResponse {
  final List<OpenAIEmbeddingData> data;

  OpenAIEmbeddingResponse({required this.data});

  factory OpenAIEmbeddingResponse.fromJson(Map<String, dynamic> json) {
    return OpenAIEmbeddingResponse(
      data: (json['data'] as List)
          .map((e) => OpenAIEmbeddingData.fromJson(e))
          .toList(),
    );
  }
}

class OpenAIEmbeddingData {
  final List<double> embedding;

  OpenAIEmbeddingData({required this.embedding});

  factory OpenAIEmbeddingData.fromJson(Map<String, dynamic> json) {
    return OpenAIEmbeddingData(
      embedding: List<double>.from(json['embedding']),
    );
  }
}

