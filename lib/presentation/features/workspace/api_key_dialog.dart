import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/api_key_provider.dart';

class ApiKeyDialog extends ConsumerStatefulWidget {
  const ApiKeyDialog({super.key});

  @override
  ConsumerState<ApiKeyDialog> createState() => _ApiKeyDialogState();
}

class _ApiKeyDialogState extends ConsumerState<ApiKeyDialog> {
  final _controller = TextEditingController();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set OpenAI API Key'),
      content: TextField(
        controller: _controller,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'sk-...',
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saving
              ? null
              : () async {
                  setState(() => _saving = true);

                  final save =
                      ref.read(saveOpenAIApiKeyProvider);
                  await save(_controller.text.trim());

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
