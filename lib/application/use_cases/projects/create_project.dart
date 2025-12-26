import '../../../domain/entities/project.dart';
import '../../../domain/services/project_repository.dart';

class CreateProject {
  final ProjectRepository repository;

  CreateProject(this.repository);

  Future<Project> execute(String name, String description) {
    return repository.create(name, description);
  }
}
