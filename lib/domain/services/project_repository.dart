import '../entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> list();
  Future<Project> create(String name, String description);
  Future<void> delete(String projectId);
}
