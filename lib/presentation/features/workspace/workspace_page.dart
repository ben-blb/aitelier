import 'package:flutter/material.dart';

import '../../../application/use_cases/projects/create_project.dart';
import '../../../application/use_cases/projects/list_projects.dart';
import '../../../application/use_cases/projects/delete_project.dart';
import '../../../domain/entities/project.dart';
import '../../../infrastructure/storage/local_project_repository.dart';
import '../../../infrastructure/storage/local_workspace_storage.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  late final LocalProjectRepository repository;
  List<Project> projects = [];

  @override
  void initState() {
    super.initState();
    repository = LocalProjectRepository(LocalWorkspaceStorage());
    _load();
  }

  Future<void> _load() async {
    final list = await ListProjects(repository).execute();
    setState(() {
      projects = list;
    });
  }

  Future<void> _create() async {
    await CreateProject(repository).execute('New Project ${projects.length}', 'Project description');
    await _load();
  }

  Future<void> _delete(String id) async {
    await DeleteProject(repository).execute(id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _create,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: projects.map((p) {
          return ListTile(
            title: Text(p.name),
            subtitle: Text(p.id),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _delete(p.id),
            ),
          );
        }).toList(),
      ),
    );
  }
}
