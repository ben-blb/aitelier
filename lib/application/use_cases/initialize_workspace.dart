import '../../domain/entities/workspace.dart';
import '../../domain/services/workspace_storage.dart';

class InitializeWorkspace {
  final WorkspaceStorage storage;

  InitializeWorkspace(this.storage);

  Future<Workspace> execute() async {
    final existing = await storage.load();
    if (existing != null) {
      return existing;
    }
    return await storage.create();
  }
}
