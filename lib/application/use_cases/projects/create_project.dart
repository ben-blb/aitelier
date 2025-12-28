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
    final createdDir = await repository.createProjectDir(name);
    await git.initRepository(createdDir.projectRoot);

    var project = await repository.create(
      createdDir.projectRoot,
      createdDir.id,
      createdDir.projectsRoot,
      name,
      description,
      remoteUrl
    );

    await git.commitAll(project.rootPath, 'state: project created');

    if (remoteUrl != null && remoteUrl.trim().isNotEmpty) {
      await git.addRemote(project.rootPath, remoteUrl);
      project = project.copyWith(remoteUrl: remoteUrl);
      await repository.save(project);
    }

    return project;
  }
}
