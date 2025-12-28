import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../domain/entities/project.dart';
import '../../domain/services/project_repository.dart';
import '../../domain/services/file_system.dart';
import 'local_workspace_storage.dart';

class LocalProjectRepository implements ProjectRepository {
  static const _projectsDir = 'projects';
  static const _indexFile = 'index.json';

  final FileSystem fs;
  final LocalWorkspaceStorage workspaceStorage;
  final _uuid = const Uuid();

  LocalProjectRepository({
    required this.fs,
    required this.workspaceStorage,
  });

  @override
  Future<List<Project>> list() async {
    final workspace = await workspaceStorage.load();
    if (workspace == null) {
      return [];
    }

    final indexPath =
        '${workspace.rootPath}/$_projectsDir/$_indexFile';

    if (!await fs.exists(indexPath)) {
      return [];
    }

    final raw = await fs.readFile(indexPath);
    final list = jsonDecode(raw) as List;

    return list.map((e) {
      return Project(
        id: e['id'],
        name: e['name'],
        description: e['description'],
        createdAt: DateTime.parse(e['createdAt']),
        rootPath: e['rootPath'],
        remoteUrl: e['remoteUrl'],
      );
    }).toList();
  }

  @override
  Future<Project> getById(String projectId) async {
    final workspace = await workspaceStorage.load();
    if (workspace == null) {
      throw Exception('Project not found');
    }

    final projectPath = '${workspace.rootPath}/$_projectsDir/$projectId';
    final filePath = '$projectPath/project.json';

    final contents = await fs.readFile(filePath);
    final data = jsonDecode(contents);

    return Project(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      createdAt: DateTime.parse(data['createdAt']),
      rootPath: data['rootPath'],
      remoteUrl: data['remoteUrl'],
    );
  }

  @override
  Future<void> save(Project project) async {
    final filePath = '${project.rootPath}/project.json';

    final json = jsonEncode({
      'id': project.id,
      'name': project.name,
      'description': project.description,
      'createdAt': project.createdAt.toIso8601String(),
      'rootPath': project.rootPath,
      'remoteUrl': project.remoteUrl,
    });

    await fs.writeFileAtomic(filePath, json);
  }

  @override
  Future<Project> create(String name, String description, String? remoteUrl) async {
    final workspace = await workspaceStorage.load();
    if (workspace == null) {
      throw Exception('Workspace not initialized');
    }

    final projectsRoot =
        '${workspace.rootPath}/$_projectsDir';
    await fs.createDirectory(projectsRoot);

    final id = _uuid.v4();
    final projectRoot = '$projectsRoot/$id';
    await fs.createDirectory(projectRoot);

    final project = Project(
      id: id,
      name: name,
      description: description,
      createdAt: DateTime.now(),
      rootPath: projectRoot,
      remoteUrl: remoteUrl
    );

    await fs.writeFileAtomic(
      '$projectRoot/project.json',
      jsonEncode({
        'id': project.id,
        'name': project.name,
        'description': project.description,
        'remoteUrl': project.remoteUrl,
        'createdAt': project.createdAt.toIso8601String(),
      }),
    );

    final projects = await list();
    final updated = [...projects, project];

    await fs.writeFileAtomic(
      '$projectsRoot/$_indexFile',
      jsonEncode(updated.map(_toIndex).toList()),
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

    await fs.deleteDirectory(
      '${workspace.rootPath}/$_projectsDir/$projectId',
    );

    await fs.writeFileAtomic(
      '${workspace.rootPath}/$_projectsDir/$_indexFile',
      jsonEncode(remaining.map(_toIndex).toList()),
    );
  }

  Map<String, dynamic> _toIndex(Project p) {
    return {
      'id': p.id,
      'name': p.name,
      'description': p.description,
      'remoteUrl': p.remoteUrl,
      'createdAt': p.createdAt.toIso8601String(),
      'rootPath': p.rootPath,
    };
  }
}
