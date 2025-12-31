
import 'package:aitelier/application/use_cases/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/project.dart';

final projectListProvider = AsyncNotifierProvider<ProjectListController, List<Project>>(ProjectListController.new);

class ProjectListController extends AsyncNotifier<List<Project>> {
  late final _listProjects = ref.read(listProjectsUseCaseProvider);
  late final _createProject = ref.read(createProjectUseCaseProvider);
  late final _deleteProject = ref.read(deleteProjectUseCaseProvider);

  @override
  Future<List<Project>> build() async {
    return _listProjects.execute();
  }

  Future<void> createProject() async {
    final currentList = state.value ?? [];
    
    state = const AsyncLoading();

    try {
      final newName = 'New Project ${currentList.length + 1}';
      
      await _createProject.execute(
        name: newName,
        description: 'Project description',
        remoteUrl: '',
      );

      ref.invalidateSelf(); 
      await future;
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> deleteProject(String id) async {
    final previousState = state.value;
    if (previousState != null) {
      state = AsyncData(previousState.where((p) => p.id != id).toList());
    }

    try {
      await _deleteProject.execute(id);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      ref.invalidateSelf();
    }
  }
}