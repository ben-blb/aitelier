import '../../../domain/entities/project.dart';
import '../../../domain/services/project_repository.dart';
import '../../../domain/services/git.service.dart';

class CreateProject {
  final ProjectRepository repository;
  final GitService git;

  CreateProject({
    required this.repository,
    required this.git,
  });

  Future<Project> execute(String name, String description) async {
    final project = await repository.create(name, description);

    await git.initRepository(project.rootPath);
    await git.commitAll(
      project.rootPath,
      'state: project created',
    );

    return project;
  }
}
