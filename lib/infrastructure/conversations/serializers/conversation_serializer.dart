import 'dart:convert';
import '../models/conversation_record.dart';

class ConversationSerializer {
  static Map<String, dynamic> toJson(ConversationRecord record) {
    return {
      'id': record.id,
      'projectId': record.projectId,
      'purpose': {
        'key': record.purposeKey,
        'description': record.purposeDescription,
      },
      'createdAt': record.createdAt.toIso8601String(),
      'updatedAt': record.updatedAt.toIso8601String(),
      'isArchived': record.isArchived,
    };
  }

  static ConversationRecord fromJson(Map<String, dynamic> json) {
    return ConversationRecord(
      id: json['id'],
      projectId: json['projectId'],
      purposeKey: json['purpose']['key'],
      purposeDescription: json['purpose']['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isArchived: json['isArchived'],
    );
  }

  static String encode(ConversationRecord record) {
    return jsonEncode(toJson(record));
  }

  static ConversationRecord decode(String raw) {
    return fromJson(jsonDecode(raw));
  }
}
