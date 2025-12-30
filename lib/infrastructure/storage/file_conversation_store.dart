import 'dart:io';
import 'package:aitelier/domain/entities/conversation.dart';
import 'package:path/path.dart' as p;
import 'package:aitelier/core/utils/logger.dart';

import '../conversations/models/conversation_index_record.dart';
import '../conversations/models/conversation_message_record.dart';
import '../conversations/serializers/conversation_index_serializer.dart';
import '../conversations/serializers/conversation_serializer.dart';
import '../conversations/serializers/message_serializer.dart';

class FileConversationStore {
  final Directory root;

  FileConversationStore(this.root);

  Directory _conversationDir(String id, String projectId) {
    final cleanPath = p.join(root.path, projectId, 'conversations', id);
    return Directory(cleanPath);
  }

  File _metaFile(String id, String projectId) {
    return File(p.join(_conversationDir(id, projectId).path, 'meta.json'));
  }

  File _messagesFile(String id, String projectId) {
    return File(p.join(_conversationDir(id, projectId).path, 'messages.log'));
  }

  File _indexFile(String id, String projectId) {
    return File(p.join(_conversationDir(id, projectId).path, 'index.json'));
  }

  Future<void> createConversation(Conversation record) async {
    final dir = _conversationDir(record.id.value, record.projectId.value);
    
    appLogger.i('Creating conversation at: ${dir.path}');

    if (!await dir.exists()) {
      try {
        await dir.create(recursive: true);
      } catch (e) {
        appLogger.e('Failed to create directory: ${dir.path}', error: e);
        rethrow;
      }
    }

    ConversationIndexRecord conversationIndexRecord = ConversationIndexRecord(
                                                        id: record.id.value,
                                                        messageCount: 0,
                                                        lastMessageAt: DateTime.now(),
                                                        lastRole: 'system'
                                                      );

    await _metaFile(record.id.value, record.projectId.value)
        .writeAsString(ConversationSerializer.encode(record));

    await _messagesFile(record.id.value, record.projectId.value).create();

    await _indexFile(record.id.value, record.projectId.value).writeAsString(
      ConversationIndexSerializer.encode(conversationIndexRecord),
    );
  }

  Future<void> appendMessage(
    String projectId,
    String conversationId,
    ConversationMessageRecord message,
  ) async {
    final messagesFile = _messagesFile(conversationId, projectId);
    final indexFile = _indexFile(conversationId, projectId);

    await messagesFile.writeAsString(
      '${MessageSerializer.encodeLine(message)}\n',
      mode: FileMode.append,
    );

    ConversationIndexRecord index;

    if (await indexFile.exists()) {
      index = ConversationIndexSerializer.decode(
        await indexFile.readAsString(),
      );
    } else {
      index = ConversationIndexRecord(
        id: conversationId,
        messageCount: 0,
        lastMessageAt: message.timestamp,
        lastRole: message.role,
      );
    }

    final updated = index.copyWith(
      messageCount: index.messageCount + 1,
      lastMessageAt: message.timestamp,
      lastRole: message.role,
    );

    await indexFile.writeAsString(
      ConversationIndexSerializer.encode(updated),
    );
  }

  Future<List<ConversationMessageRecord>> readMessages({
    required String projectId,
    required String conversationId,
  }) async {
    final file = _messagesFile(conversationId, projectId);

    if (!await file.exists()) {
      return [];
    }

    final lines = await file.readAsLines();

    return lines
        .where((line) => line.trim().isNotEmpty)
        .map(MessageSerializer.decodeLine)
        .toList();
  }

}
