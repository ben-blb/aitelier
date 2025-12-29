import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app_container.dart';
import '../../../application/use_cases/projects/create_project.dart';
import '../../../application/use_cases/projects/list_projects.dart';
import '../../../application/use_cases/projects/delete_project.dart';
import '../../../domain/entities/project.dart';
import '../../../domain/value_objects/project_id.dart';
import '../../../infrastructure/git/local_git_service.dart';
import '../../../infrastructure/storage/local_file_system.dart';
import '../../../infrastructure/storage/local_project_repository.dart';
import '../../../infrastructure/storage/local_workspace_storage.dart';
import '../conversation/project_conversations_screen.dart';

class WorkspacePage extends StatefulWidget {
  final AppContainer container;
  
  WorkspacePage({
    super.key,
    required this.container
  });

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  late final LocalProjectRepository repository;
  String? basePath;
  final fs = LocalFileSystem();
  final git = LocalGitService();
  List<Project> projects = [];

  Future<void> _resolveBasePath() async {
    final dir = await getApplicationSupportDirectory();
    basePath = dir.path;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _resolveBasePath();
    final fs = LocalFileSystem();

    final workspaceStorage = LocalWorkspaceStorage(
      fs: fs,
      basePath: basePath!,
    );

    repository = LocalProjectRepository(
      fs: fs,
      workspaceStorage: workspaceStorage,
    );

    await _load();
  }


  Future<void> _load() async {
    final list = await ListProjects(repository).execute();
    setState(() {
      projects = list;
    });
  }

  Future<void> _create() async {
    await CreateProject(repository: repository, git: git).execute(name: 'New Project ${projects.length}', description: 'Project description', remoteUrl:  '');
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProjectConversationsScreen(
                    projectId: ProjectId(p.id),
                    projectName: p.name,
                    container: widget.container,
                  ),
                ),
              );
            },
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
