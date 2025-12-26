import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';

import '../../domain/entities/project.dart';
import '../../domain/services/project_repository.dart';
import 'local_workspace_storage.dart';

class LocalProjectRepository implements ProjectRepository {
  static const _projectsDirName = 'projects';
  static const _indexFileName = 'index.json';

  final _uuid = const Uuid();
  final LocalWorkspaceStorage workspaceStorage;

  LocalProjectRepository(this.workspaceStorage);

  @override
  Future<List<Project>> list() async {
    final workspace = await workspaceStorage.load();
    if (workspace == null) {
      return [];
    }

    final indexFile = _indexFile(workspace.rootPath);
    if (!indexFile.existsSync()) {
      return [];
    }

    final raw = jsonDecode(indexFile.readAsStringSync()) as List;
    return raw.map((e) {
      return Project(
        id: e['id'],
        name: e['name'],
        description: e['description'],
        createdAt: DateTime.parse(e['createdAt']),
        rootPath: e['rootPath'],
      );
    }).toList();
  }

  @override
  Future<Project> create(String name, String description) async {
    final workspace = await workspaceStorage.load();
    if (workspace == null) {
      throw Exception('Workspace not initialized');
    }

    final projectsDir =
        Directory('${workspace.rootPath}/$_projectsDirName');
    projectsDir.createSync(recursive: true);

    final id = _uuid.v4();
    final projectDir = Directory('${projectsDir.path}/$id');
    projectDir.createSync();

    final project = Project(
      id: id,
      name: name,
      description: description,
      createdAt: DateTime.now(),
      rootPath: projectDir.path,
    );

    File('${projectDir.path}/project.json').writeAsStringSync(
      jsonEncode({
        'id': project.id,
        'name': project.name,
        'description': project.description,
        'createdAt': project.createdAt.toIso8601String(),
      }),
    );

    final projects = await list();
    final updated = [...projects, project];

    _indexFile(workspace.rootPath).writeAsStringSync(
      jsonEncode(updated.map(_toIndexEntry).toList()),
    );

    return project;
  }

  @override
  Future<void> delete(String projectId) async {
    final workspace = await workspaceStorage.load();
    if (workspace == null) {
      return;
    }

    final projects = await list();
    final remaining =
        projects.where((p) => p.id != projectId).toList();

    final dir = Directory(
      '${workspace.rootPath}/$_projectsDirName/$projectId',
    );
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }

    _indexFile(workspace.rootPath).writeAsStringSync(
      jsonEncode(remaining.map(_toIndexEntry).toList()),
    );
  }

  File _indexFile(String root) {
    return File('$root/$_projectsDirName/$_indexFileName');
  }

  Map<String, dynamic> _toIndexEntry(Project p) {
    return {
      'id': p.id,
      'name': p.name,
      'description': p.description,
      'createdAt': p.createdAt.toIso8601String(),
      'rootPath': p.rootPath,
    };
  }
}
