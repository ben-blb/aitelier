import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/value_objects/conversation_purpose.dart';
import '../../../domain/value_objects/project_id.dart';
import 'conversation_screen.dart';
import 'project_conversations_controller.dart'; 

class ProjectConversationsScreen extends ConsumerWidget {
  final ProjectId projectId;
  final String projectName;

  const ProjectConversationsScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  Future<void> _createConversation(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<_NewConversationResult>(
      context: context,
      builder: (_) => const _NewConversationDialog(),
    );

    if (result == null) return;

    final controller = ref.read(projectConversationsProvider(projectId).notifier);
    
    final newConversation = await controller.createConversation(
      title: result.title,
      purpose: result.purpose,
    );

    if (newConversation != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ConversationScreen(
            conversationId: newConversation.id,
            projectId: projectId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConversations = ref.watch(projectConversationsProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: Text(projectName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New conversation',
            onPressed: () => _createConversation(context, ref),
          ),
        ],
      ),
      body: asyncConversations.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (conversations) {
          if (conversations.isEmpty) {
             return const Center(child: Text('No conversations yet.'));
          }
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final convo = conversations[index];
              return ListTile(
                title: Text(convo.title),
                subtitle: Text(convo.purpose.value),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConversationScreen(
                        conversationId: convo.id,
                        projectId: projectId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _NewConversationResult {
  final String title;
  final ConversationPurpose? purpose;

  _NewConversationResult({
    required this.title,
    this.purpose,
  });
}

class _NewConversationDialog extends StatefulWidget {
  const _NewConversationDialog();

  @override
  State<_NewConversationDialog> createState() => _NewConversationDialogState();
}

class _NewConversationDialogState extends State<_NewConversationDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  bool get _isValid => _titleController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_isValid) return;

    Navigator.pop(
      context,
      _NewConversationResult(
        title: _titleController.text.trim(),
        purpose: _purposeController.text.trim().isEmpty
            ? null
            : ConversationPurpose(_purposeController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Conversation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'e.g. API Design Discussion',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _purposeController,
            decoration: const InputDecoration(
              labelText: 'Purpose (optional)',
              hintText: 'general, coding, planning...',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isValid ? _submit : null,
          child: const Text('Create'),
        ),
      ],
    );
  }
}