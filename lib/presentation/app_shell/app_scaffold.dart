import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Aitelier booted',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
