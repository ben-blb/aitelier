import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';

import '../../../app_container.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/value_objects/conversation_id.dart';
import '../../../domain/value_objects/conversation_purpose.dart';
import '../../../domain/value_objects/project_id.dart';
import 'conversation_screen.dart';

class ProjectConversationsScreen extends StatefulWidget {
  final ProjectId projectId;
  final String projectName;
  final AppContainer container;
  

  const ProjectConversationsScreen({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.container
  });

  @override
  State<ProjectConversationsScreen> createState() =>
      _ProjectConversationsScreenState();
}

class _ProjectConversationsScreenState
    extends State<ProjectConversationsScreen> {
  List<Conversation> conversations = [];

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    // TODO: ListConversationsByProjectUseCase
    setState(() {});
  }

  Future<void> _createConversation() async {
    final result = await showDialog<_NewConversationResult>(
      context: context,
      builder: (_) => const _NewConversationDialog(),
    );

    if (result == null) return;

    final conversationId = ConversationId(UuidV4().generate());

    final conversation = await widget.container.createConversationUseCase.execute(
      id: conversationId,
      projectId: widget.projectId,
      title: result.title,
      purpose: result.purpose,
    );

    setState(() {
      conversations.insert(0, conversation);
    });

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConversationScreen(
          conversationId: conversation.id.value,
          projectId: widget.projectId,
          container: widget.container,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New conversation',
            onPressed: _createConversation,
          ),
        ],
      ),
      body: ListView.builder(
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
                    conversationId: convo.id.value,
                    projectId: widget.projectId,
                    container: widget.container,
                  ),
                ),
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
  State<_NewConversationDialog> createState() =>
      _NewConversationDialogState();
}

class _NewConversationDialogState extends State<_NewConversationDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  bool get _isValid => _titleController.text.trim().isNotEmpty;

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
