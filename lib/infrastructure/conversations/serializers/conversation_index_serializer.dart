import 'dart:convert';

import '../models/conversation_index_record.dart';

class ConversationIndexSerializer {
  static Map<String, dynamic> toJson(ConversationIndexRecord record) {
    return {
      'id': record.id,
      'messageCount': record.messageCount,
      'lastMessageAt': record.lastMessageAt.toIso8601String(),
      'lastRole': record.lastRole
    };
  }

  static ConversationIndexRecord fromJson(Map<String, dynamic> json) {
    return ConversationIndexRecord(
      id: json['id'],
      messageCount: json['messageCount'] ?? 0,
      lastMessageAt: DateTime.parse(json['lastMessageAt']),
      lastRole: json['lastRole']
    );
  }

  static String encode(ConversationIndexRecord record) {
    return jsonEncode(toJson(record));
  }

  static ConversationIndexRecord decode(String raw) {
    return fromJson(jsonDecode(raw));
  }
}
