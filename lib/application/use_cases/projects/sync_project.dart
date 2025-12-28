import '../../../domain/services/project_repository.dart';
import '../../../domain/services/git_service.dart';

class SyncProject {
  final ProjectRepository repository;
  final GitService git;

  SyncProject({
    required this.repository,
    required this.git,
  });

  Future<void> execute(String projectId) async {
    final project = await repository.getById(projectId);

    if (project.remoteUrl == null) {
      throw Exception('Project has no remote');
    }

    await git.push(project.rootPath);
  }
}
