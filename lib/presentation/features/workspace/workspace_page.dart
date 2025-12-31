// features/projects/ui/workspace_page.dart

import 'package:aitelier/presentation/features/conversation/projects_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/value_objects/project_id.dart';
import '../conversation/project_conversations_screen.dart';

class WorkspacePage extends ConsumerWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProjects = ref.watch(projectListProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(projectListProvider.notifier).createProject(),
        child: const Icon(Icons.add),
      ),
      body: asyncProjects.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (projects) {
          if (projects.isEmpty) {
            return const Center(child: Text('No projects yet. Click + to add one.'));
          }
          
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ListTile(
                title: Text(project.name),
                subtitle: Text(project.id),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProjectConversationsScreen(
                        projectId: ProjectId(project.id),
                        projectName: project.name,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => ref.read(projectListProvider.notifier).deleteProject(project.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}