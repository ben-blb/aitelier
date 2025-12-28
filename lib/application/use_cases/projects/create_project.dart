import '../../../domain/entities/project.dart';
import '../../../domain/services/project_repository.dart';
import '../../../domain/services/git_service.dart';

class CreateProject {
  final ProjectRepository repository;
  final GitService git;

  CreateProject({
    required this.repository,
    required this.git,
  });

  Future<Project> execute({
    required String name,
    required String description,
    String? remoteUrl,
  }) async {
    var project = await repository.create(name, description, remoteUrl);

    await git.initRepository(project.rootPath);
    await git.commitAll(project.rootPath, 'state: project created');

    if (remoteUrl != null) {
      await git.addRemote(project.rootPath, remoteUrl);
      project = project.copyWith(remoteUrl: remoteUrl);
      await repository.save(project);
    }

    return project;
  }
}
