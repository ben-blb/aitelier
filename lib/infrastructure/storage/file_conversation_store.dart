import 'dart:io';
import '../conversations/models/conversation_record.dart';
import '../conversations/models/conversation_message_record.dart';
import '../conversations/serializers/conversation_serializer.dart';
import '../conversations/serializers/message_serializer.dart';

class FileConversationStore {
  final Directory root;

  FileConversationStore(this.root);

  Directory _conversationDir(String id) {
    return Directory('${root.path}/$id');
  }

  File _metaFile(String id) {
    return File('${_conversationDir(id).path}/meta.json');
  }

  File _messagesFile(String id) {
    return File('${_conversationDir(id).path}/messages.log');
  }

  File _indexFile(String id) {
    return File('${_conversationDir(id).path}/index.json');
  }

  Future<void> createConversation(ConversationRecord record) async {
    final dir = _conversationDir(record.id);
    await dir.create(recursive: true);

    await _metaFile(record.id)
        .writeAsString(ConversationSerializer.encode(record));

    await _messagesFile(record.id).create();

    await _indexFile(record.id).writeAsString(
      ConversationSerializer.encode(record),
    );
  }

  Future<void> appendMessage(
    String conversationId,
    ConversationMessageRecord message,
  ) async {
    final file = _messagesFile(conversationId);
    await file.writeAsString(
      '${MessageSerializer.encodeLine(message)}\n',
      mode: FileMode.append,
    );
  }
}
