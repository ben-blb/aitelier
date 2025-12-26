import '../../../domain/services/project_repository.dart';

class DeleteProject {
  final ProjectRepository repository;

  DeleteProject(this.repository);

  Future<void> execute(String projectId) {
    return repository.delete(projectId);
  }
}
