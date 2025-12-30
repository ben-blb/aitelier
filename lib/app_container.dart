import 'dart:io';

import 'package:aitelier/infrastructure/conversations/models/conversation_dao.dart';
import 'package:aitelier/infrastructure/git/conversation_git_hook.dart';
import 'package:aitelier/infrastructure/git/local_git_service.dart';
import 'application/use_cases/conversations/append_message_use_case.dart';
import 'application/use_cases/conversations/create_conversation.dart';
import 'application/use_cases/conversations/get_conversation_messages_use_case.dart';
import 'core/database/app_database.dart';
import 'domain/services/conversation_git_hook.dart';
import 'infrastructure/conversations/drift_conversation_repository.dart';
import 'infrastructure/storage/file_conversation_store.dart';

class AppContainer {
  final AppDatabase database;
  final Directory projectsRoot;

  late final ConversationDao conversationDao;
  late final DriftConversationRepository conversationRepository;
  late final FileConversationStore conversationStore;
  late final CreateConversationUseCase createConversationUseCase;
  late final AppendMessageUseCase appendMessageUseCase;
  late final GetConversationMessagesUseCase getConversationMessagesUseCase;


  late final ConversationGitHook conversationGitHook;

  AppContainer({
    required this.database,
    required this.projectsRoot,
  }) {
    conversationDao = ConversationDao(database);
    conversationRepository = DriftConversationRepository(conversationDao);
    conversationStore = FileConversationStore(projectsRoot);
    conversationGitHook = LocalConversationGitHook(
      root: projectsRoot,
      git: LocalGitService()
    );

    createConversationUseCase = CreateConversationUseCase(
      fileStore: conversationStore,
      conversationRepository: conversationRepository,
    );

    appendMessageUseCase = AppendMessageUseCase(
      fileStore: conversationStore,
      conversationRepository: conversationRepository,
      gitHook: conversationGitHook
    );

    getConversationMessagesUseCase = GetConversationMessagesUseCase(
      fileStore: conversationStore,
    );
  }
}
