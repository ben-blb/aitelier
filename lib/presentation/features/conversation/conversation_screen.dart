import 'package:aitelier/app_container.dart';
import 'package:aitelier/domain/value_objects/conversation_id.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/conversations/models/conversation_message_record.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class ConversationScreen extends StatefulWidget {
  final String conversationId;
  final ProjectId projectId;
  final AppContainer container;

  const ConversationScreen({
    super.key,
    required this.conversationId,
    required this.container,
    required this.projectId
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ConversationMessageRecord> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final newMessages = await widget.container
        .getConversationMessagesUseCase
        .execute(
          projectId: widget.projectId,
          conversationId: ConversationId(widget.conversationId),
        );

    if (!mounted) return;
    setState(() {
      messages = newMessages;
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();

    final message = ConversationMessageRecord(
      role: 'user',
      content: text,
      timestamp: DateTime.now(),
    );

    // Optimistic UI update
    setState(() {
      messages.add(message);
    });

    _scrollToBottom();

    // Application layer
    await widget.container.appendMessageUseCase.execute(
      conversationId: ConversationId(widget.conversationId),
      projectId: widget.projectId,
      message: message,
    );

    // TODO (next step): trigger AI response pipeline
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          _MessageInput(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInput({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: onSend,
            ),
          ],
        ),
      ),
    );
  }
}
