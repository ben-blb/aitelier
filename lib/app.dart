import 'package:flutter/material.dart';
import 'presentation/app_shell/app_scaffold.dart';

class AitelierApp extends StatelessWidget {
  const AitelierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aitelier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const AppScaffold(),
    );
  }
}
