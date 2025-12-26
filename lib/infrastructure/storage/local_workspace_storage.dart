import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../domain/entities/workspace.dart';
import '../../domain/services/workspace_storage.dart';

class LocalWorkspaceStorage implements WorkspaceStorage {
  static const _settingsFile = 'workspace.settings.json';

  @override
  Future<Workspace?> load() async {
    final root = await _resolveRoot();
    final file = File('${root.path}/$_settingsFile');

    if (!file.existsSync()) {
      return null;
    }

    final data = jsonDecode(file.readAsStringSync());
    return Workspace(
      rootPath: root.path,
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  @override
  Future<Workspace> create() async {
    final root = await _resolveRoot();
    if (!root.existsSync()) {
      root.createSync(recursive: true);
    }

    final workspace = Workspace(
      rootPath: root.path,
      createdAt: DateTime.now(),
    );

    final file = File('${root.path}/$_settingsFile');
    file.writeAsStringSync(
      jsonEncode({
        'createdAt': workspace.createdAt.toIso8601String(),
      }),
    );

    return workspace;
  }

  Future<Directory> _resolveRoot() async {
    final base = await getApplicationSupportDirectory();
    return Directory('${base.path}/');
  }
}
