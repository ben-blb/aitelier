import 'package:flutter/material.dart';
import 'core/purpose/loader/purpose_registry.dart';
import 'presentation/app_shell/app_scaffold.dart';

class AitelierApp extends StatelessWidget {
  final PurposeRegistry purposeRegistry;
  
  const AitelierApp({
    super.key,
    required this.purposeRegistry,
  });

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
