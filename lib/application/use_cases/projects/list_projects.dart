import '../../../domain/entities/project.dart';
import '../../../domain/services/project_repository.dart';

class ListProjects {
  final ProjectRepository repository;

  ListProjects(this.repository);

  Future<List<Project>> execute() {
    return repository.list();
  }
}
