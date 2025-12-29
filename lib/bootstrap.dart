import 'dart:async';
import 'dart:io'; // Added for Platform check
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Added for FFI init
import 'package:path/path.dart' as p;

import 'app_container.dart';
import 'core/utils/logger.dart';
import 'app.dart';
import 'infrastructure/database/sqlite_database.dart';
import 'core/purpose/loader/purpose_folder_loader.dart';
import 'core/purpose/loader/purpose_registry.dart';

Future<void> bootstrapApp() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      FlutterError.onError = (details) {
        appLogger.e(
          'Flutter framework error',
          error: details.exception,
          stackTrace: details.stack,
        );
      };

      appLogger.i('Starting Aitelier bootstrap');

      appLogger.i('Initializing SQLite');
      final db = await SqliteDatabase.open();
      appLogger.i('SQLite DB path: ${db.path}');
      
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
        database: db,
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