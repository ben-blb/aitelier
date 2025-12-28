import '../entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> list();
  Future<({
    String projectsRoot,
    String id,
    String projectRoot,
  })>  createProjectDir(String name);
  Future<Project> create(
    String projectRoot,
    String id,
    String projectsRoot,
    String name,
    String description,
    String? remoteUrl
  );
  Future<void> delete(String projectId);
  Future<Project> getById(String projectId);
  Future<void> save(Project project);
}
