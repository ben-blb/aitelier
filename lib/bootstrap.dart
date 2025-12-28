import 'dart:async';
import 'package:flutter/material.dart';

import 'core/utils/logger.dart';
import 'app.dart';
import 'infrastructure/database/sqlite_database.dart';
import 'core/purpose/loader/purpose_folder_loader.dart';
import 'core/purpose/loader/purpose_registry.dart';

Future<void> bootstrapApp() async {
  runZonedGuarded(
    () async {
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

      appLogger.i('Initializing purpose registry');
      final purposeRegistry = PurposeRegistry();

      await PurposeFolderLoader.loadAllFromFolder(
        folderPath: 'assets/purposes/',
        registry: purposeRegistry,
      );

      appLogger.i(
        'Bootstrap completed. Loaded ${purposeRegistry.listAll().length} purposes',
      );

      runApp(
        AitelierApp(
          purposeRegistry: purposeRegistry,
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
