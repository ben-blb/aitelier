import '../entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> list();
  Future<Project> create(String name, String description, String? remoteUrl);
  Future<void> delete(String projectId);
  Future<Project> getById(String projectId);
  Future<void> save(Project project);
}
