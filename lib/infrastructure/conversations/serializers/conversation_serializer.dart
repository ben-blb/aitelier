import 'dart:convert';
import 'package:aitelier/domain/entities/conversation.dart';
import 'package:aitelier/domain/entities/conversation_metadata.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/conversation_purpose.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';

import '../../../domain/value_objects/conversation_status.dart';


class ConversationSerializer {
  static Map<String, dynamic> toJson(Conversation record) {
    return {
      'id': record.id.value,
      'projectId': record.projectId.value,
      'purpose': record.purpose.value,
      'title': record.title,
      'status': record.status.name,
      'createdAt': record.metadata.createdAt.toIso8601String(),
      'updatedAt': record.metadata.updatedAt.toIso8601String(),
      'isArchived': record.metadata.isArchived,
    };
  }

  static Conversation fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: ConversationId(json['id']),
      projectId: ProjectId(json['projectId']),
      title: json['title'],
      status: ConversationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ConversationStatus.active,
      ),
      purpose: ConversationPurpose(json['purpose']),
      metadata: ConversationMetadata(
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        isArchived: json['isArchived']
      )
    );
  }

  static String encode(Conversation record) {
    return jsonEncode(toJson(record));
  }

  static Conversation decode(String raw) {
    return fromJson(jsonDecode(raw));
  }
}