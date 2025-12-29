import 'package:aitelier/domain/value_objects/conversation_status.dart';

class ConversationRecord {
  final String id;
  final String projectId;
  final String purposeKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  final String title;
  final ConversationStatus status;

  ConversationRecord({
    required this.id,
    required this.projectId,
    required this.purposeKey,
    required this.createdAt,
    required this.updatedAt,
    required this.isArchived,
    required this.title,
    required this.status
  });
}
