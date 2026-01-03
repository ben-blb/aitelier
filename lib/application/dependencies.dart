import 'package:aitelier/application/artifacts/use_cases/create_artifact_use_case.dart';
import 'package:aitelier/application/conversations/conversation_prompt_executor.dart';
import 'package:aitelier/application/llm/prompt/prompt_builder.dart';
import 'package:aitelier/application/llm/use_cases/execute_prompt_use_case.dart';
import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:aitelier/infrastructure/llm/llm_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conversationPromptExecutorProvider = FutureProvider<ConversationPromptExecutor>((ref) async {
  final repository = await ref.watch(llmRepositoryProvider.future);

  return ConversationPromptExecutor(
    promptBuilder: PromptBuilder(),
    executePrompt: ExecutePromptUseCase(repository,),
  );
});

final createArtifactUseCaseProvider =
    Provider<CreateArtifactUseCase>((ref) {
  return CreateArtifactUseCase(
    ref.read(artifactRepositoryProvider),
  );
});
