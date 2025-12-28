import '../../../domain/services/project_repository.dart';
import '../../../domain/services/git_service.dart';

class UpdateProjectRemote {
  final ProjectRepository repository;
  final GitService git;

  UpdateProjectRemote({
    required this.repository,
    required this.git,
  });

  Future<void> execute(String projectId, String remoteUrl) async {
    final project = await repository.getById(projectId);

    await git.addRemote(project.rootPath, remoteUrl);

    final updated = project.copyWith(remoteUrl: remoteUrl);
    await repository.save(updated);
  }
}
