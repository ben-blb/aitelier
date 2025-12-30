import 'package:aitelier/domain/value_objects/project_id.dart';

import '../../../core/utils/logger.dart';
import '../../../domain/services/conversation_git_hook.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../infrastructure/conversations/drift_conversation_repository.dart';
import '../../../infrastructure/conversations/models/conversation_message_record.dart';
import '../../../infrastructure/storage/file_conversation_store.dart';

class AppendMessageUseCase {
  final FileConversationStore fileStore;
  final DriftConversationRepository conversationRepository;
  final ConversationGitHook gitHook;

  AppendMessageUseCase({
    required this.fileStore,
    required this.conversationRepository,
    required this.gitHook
  });

  Future<void> execute({
    required ProjectId projectId,
    required ConversationId conversationId,
    required ConversationMessageRecord message,
  }) async {
    appLogger.d(
      'Appending message | conversation=${conversationId.value}',
    );

    await fileStore.appendMessage(
      projectId.value,
      conversationId.value,
      message
    );

    await conversationRepository.touch(conversationId);

    await gitHook.onMessageAppended(
      conversationId: conversationId,
      purpose: message.role,
      projectId: projectId
    );
  }
}
