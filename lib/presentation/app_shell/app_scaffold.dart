import 'package:aitelier/presentation/features/workspace/workspace_page.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: WorkspacePage());
  }
}
