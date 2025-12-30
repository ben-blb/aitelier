import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'app_container.dart';
import 'core/database/app_database.dart';
import 'core/utils/logger.dart';
import 'app.dart';
import 'core/purpose/loader/purpose_folder_loader.dart';
import 'core/purpose/loader/purpose_registry.dart';

Future<void> bootstrapApp() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      
      FlutterError.onError = (details) {
        appLogger.e(
          'Flutter framework error',
          error: details.exception,
          stackTrace: details.stack,
        );
      };

      appLogger.i('Starting Aitelier bootstrap');

      appLogger.i('Initializing SQLite');
      final database = AppDatabase();
      appLogger.i('SQLite DB version: ${database.schemaVersion}');
      
      final rootDir = await getApplicationSupportDirectory();
      final projectsDir = Directory(p.join(rootDir.path, 'workspaces', 'projects'));
      await projectsDir.create(recursive: true);

      appLogger.i('Initializing purpose registry');
      final purposeRegistry = PurposeRegistry();

      await PurposeFolderLoader.loadAllFromFolder(
        folderPath: 'assets/purposes/',
        registry: purposeRegistry,
      );

      final container = AppContainer(
        database: database,
        projectsRoot: projectsDir,
      );

      appLogger.i(
        'Bootstrap completed. Loaded ${purposeRegistry.listAll().length} purposes',
      );

      runApp(
        AitelierApp(
          purposeRegistry: purposeRegistry,
          container: container,
        ),
      );
    },
    (error, stack) {
      appLogger.f(
        'Uncaught zone error during bootstrap',
        error: error,
        stackTrace: stack,
      );
    },
  );
}