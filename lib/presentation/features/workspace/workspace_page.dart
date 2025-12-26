import 'package:flutter/material.dart';

import '../../../application/use_cases/initialize_workspace.dart';
import '../../../infrastructure/storage/local_workspace_storage.dart';
import '../../../domain/entities/workspace.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  Workspace? workspace;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final useCase = InitializeWorkspace(
      LocalWorkspaceStorage(),
    );

    final result = await useCase.execute();
    setState(() {
      workspace = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (workspace == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Text(
        'Workspace ready at:\n${workspace!.rootPath}',
        textAlign: TextAlign.center,
      ),
    );
  }
}
