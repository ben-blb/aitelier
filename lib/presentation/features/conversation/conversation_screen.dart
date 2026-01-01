import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/presentation/features/conversation/conversation_controller.dart';
import 'package:aitelier/presentation/features/conversation/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationScreen extends ConsumerWidget {
  final ConversationId conversationId;
  final ProjectId projectId;

  const ConversationScreen({
    super.key,
    required this.conversationId,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationKey = (projectId: projectId, conversationId: conversationId);
    final asyncMessages = ref.watch(conversationScreenProvider(conversationKey));

    return Scaffold(
      appBar: AppBar(title: const Text('Conversation')),
      body: Column(
        children: [
          Expanded(
            child: asyncMessages.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (messages) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) => MessageBubble(message: messages[index]),
                );
              },
            ),
          ),
          _MessageInput(
            onSend: (text) {
              ref.read(conversationScreenProvider(conversationKey).notifier).sendMessage(text);
            },
          ),
        ],
      ),
    );
  }
}

class _MessageInput extends StatefulWidget {
  final ValueChanged<String> onSend;

  const _MessageInput({
    required this.onSend,
  });

  @override
  State<_MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isComposing = _controller.text.trim().isNotEmpty;
      if (_isComposing != isComposing) {
        setState(() {
          _isComposing = isComposing;
        });
      }
    });
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      _focusNode.requestFocus();
      return;
    };
    
    widget.onSend(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _handleSend(),
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _isComposing ? _handleSend : null,
            ),
          ],
        ),
      ),
    );
  }
}