import 'package:aitelier/application/use_cases/dependencies.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/conversations/models/conversation_message_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


typedef ConversationKey = ({ProjectId projectId, ConversationId conversationId});

final conversationScreenProvider = AsyncNotifierProvider.family<ConversationController, List<ConversationMessageRecord>, ConversationKey>(ConversationController.new);

class ConversationController extends FamilyAsyncNotifier<List<ConversationMessageRecord>, ConversationKey> {
  late final _getMessages = ref.read(getConversationMessagesUseCaseProvider);
  late final _appendMessage = ref.read(appendMessageUseCaseProvider);

  @override
  Future<List<ConversationMessageRecord>> build(ConversationKey arg) async {
    return _getMessages.execute(
      projectId: arg.projectId,
      conversationId: arg.conversationId,
    );
  }

  Future<void> sendMessage(String text) async {
    final currentState = state.value;
    if (currentState == null) return;

    final newMessage = ConversationMessageRecord(
      role: 'user',
      content: text,
      timestamp: DateTime.now(),
    );

    state = AsyncData([...currentState, newMessage]);

    try {
      await _appendMessage.execute(
        projectId: arg.projectId,
        conversationId: arg.conversationId,
        message: newMessage,
      );
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}