import 'dart:convert';

import '../../domain/entities/workspace.dart';
import '../../domain/services/workspace_storage.dart';
import '../../domain/services/file_system.dart';

class LocalWorkspaceStorage implements WorkspaceStorage {
  static const _settingsFile = 'workspace.settings.json';
  static const _workspaceDirName = 'workspaces';

  final FileSystem fs;
  final String basePath;

  LocalWorkspaceStorage({
    required this.fs,
    required this.basePath,
  });

  @override
  Future<Workspace?> load() async {
    final rootPath = '$basePath/$_workspaceDirName';
    final settingsPath = '$rootPath/$_settingsFile';

    final exists = await fs.exists(settingsPath);
    if (!exists) {
      return null;
    }

    final raw = await fs.readFile(settingsPath);
    final data = jsonDecode(raw);

    return Workspace(
      rootPath: rootPath,
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  @override
  Future<Workspace> create() async {
    final rootPath = '$basePath/$_workspaceDirName';
    await fs.createDirectory(rootPath);

    final workspace = Workspace(
      rootPath: rootPath,
      createdAt: DateTime.now(),
    );

    final settingsPath = '$rootPath/$_settingsFile';
    await fs.writeFileAtomic(
      settingsPath,
      jsonEncode({
        'createdAt': workspace.createdAt.toIso8601String(),
      }),
    );

    return workspace;
  }
}
