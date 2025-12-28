import 'dart:convert';
import '../models/conversation_message_record.dart';

class MessageSerializer {
  static Map<String, dynamic> toJson(ConversationMessageRecord record) {
    return {
      'role': record.role,
      'content': record.content,
      'timestamp': record.timestamp.toIso8601String(),
    };
  }

  static ConversationMessageRecord fromJson(Map<String, dynamic> json) {
    return ConversationMessageRecord(
      role: json['role'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  static String encodeLine(ConversationMessageRecord record) {
    return jsonEncode(toJson(record));
  }

  static ConversationMessageRecord decodeLine(String line) {
    return fromJson(jsonDecode(line));
  }
}
