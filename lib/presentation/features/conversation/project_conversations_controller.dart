import 'package:aitelier/application/use_cases/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/conversation_purpose.dart';
import '../../../domain/value_objects/project_id.dart';

final projectConversationsProvider = AsyncNotifierProvider.family<ProjectConversationsController, List<Conversation>, ProjectId>(ProjectConversationsController.new);

class ProjectConversationsController extends FamilyAsyncNotifier<List<Conversation>, ProjectId> {
  late final _listConversations = ref.read(listConversationsUseCaseProvider);
  late final _createConversation = ref.read(createConversationUseCaseProvider);

  @override
  Future<List<Conversation>> build(ProjectId arg) async {
    return _listConversations.execute(arg);
  }

  Future<Conversation?> createConversation({
    required String title,
    required ConversationPurpose? purpose,
  }) async {
    final newId = ConversationId(const Uuid().v4());
    
    try {
      final newConversation = await _createConversation.execute(
        id: newId,
        projectId: arg,
        title: title,
        purpose: purpose,
      );

      final previousList = state.value ?? [];
      state = AsyncData([newConversation, ...previousList]);
      
      return newConversation;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }
}