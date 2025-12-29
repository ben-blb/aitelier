import 'dart:io';

import 'package:aitelier/infrastructure/git/conversation_git_hook.dart';
import 'package:aitelier/infrastructure/git/local_git_service.dart';
import 'package:sqflite/sqflite.dart';

import 'application/use_cases/conversations/append_message_use_case.dart';
import 'application/use_cases/conversations/create_conversation.dart';
import 'application/use_cases/conversations/get_conversation_messages_use_case.dart';
import 'domain/services/conversation_git_hook.dart';
import 'infrastructure/conversations/models/sqlite_conversation_dao.dart';
import 'infrastructure/storage/file_conversation_store.dart';

class AppContainer {
  final Database database;
  final Directory projectsRoot;

  late final SqliteConversationDao conversationDao;
  late final FileConversationStore conversationStore;
  late final CreateConversationUseCase createConversationUseCase;
  late final AppendMessageUseCase appendMessageUseCase;
  late final GetConversationMessagesUseCase getConversationMessagesUseCase;


  late final ConversationGitHook conversationGitHook;

  AppContainer({
    required this.database,
    required this.projectsRoot,
  }) {
    conversationDao = SqliteConversationDao(database);
    conversationStore = FileConversationStore(projectsRoot);
    conversationGitHook = LocalConversationGitHook(
      root: projectsRoot,
      git: LocalGitService()
    );

    createConversationUseCase = CreateConversationUseCase(
      fileStore: conversationStore,
      sqliteDao: conversationDao,
    );

    appendMessageUseCase = AppendMessageUseCase(
      fileStore: conversationStore,
      sqliteDao: conversationDao,
      gitHook: conversationGitHook
    );
    getConversationMessagesUseCase = GetConversationMessagesUseCase(
      fileStore: conversationStore,
    );
  }
}
