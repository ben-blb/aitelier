import '../entities/workspace.dart';

abstract class WorkspaceStorage {
  Future<Workspace?> load();
  Future<Workspace> create();
}
