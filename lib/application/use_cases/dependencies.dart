import 'package:aitelier/application/use_cases/conversations/append_message_use_case.dart';
import 'package:aitelier/application/use_cases/conversations/create_conversation.dart';
import 'package:aitelier/application/use_cases/conversations/get_conversation_messages_use_case.dart';
import 'package:aitelier/application/use_cases/conversations/list_conversation_by_project_use_case.dart';
import 'package:aitelier/application/use_cases/projects/delete_project.dart';
import 'package:aitelier/application/use_cases/projects/list_projects.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'projects/create_project.dart';

final listProjectsUseCaseProvider = Provider<ListProjects>((ref) {
  return ListProjects(ref.watch(projectRepositoryProvider));
});

final createProjectUseCaseProvider = Provider<CreateProject>((ref) {
  return CreateProject(
    repository: ref.watch(projectRepositoryProvider),
    git: ref.watch(gitServiceProvider),
  );
});

final deleteProjectUseCaseProvider = Provider<DeleteProject>((ref) {
  return DeleteProject(ref.watch(projectRepositoryProvider));
});

final createConversationUseCaseProvider = Provider((ref) {
  return CreateConversationUseCase(
    fileStore: ref.watch(fileConversationStoreProvider),
    conversationRepository: ref.watch(conversationRepoProvider),
  );
});

final appendMessageUseCaseProvider = Provider((ref) {
  return AppendMessageUseCase(
    fileStore: ref.watch(fileConversationStoreProvider),
    conversationRepository: ref.watch(conversationRepoProvider),
    gitHook: ref.watch(conversationGitHookProvider),
  );
});

final getConversationMessagesUseCaseProvider = Provider((ref) {
  return GetConversationMessagesUseCase(
    fileStore: ref.watch(fileConversationStoreProvider),
  );
});

final listConversationsUseCaseProvider = Provider<ListConversationsByProjectUseCase>((ref) {
  return ListConversationsByProjectUseCase(
    ref.watch(conversationRepoProvider),
  );
});