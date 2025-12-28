import 'dart:async';
import 'package:flutter/material.dart';

import 'core/utils/logger.dart';
import 'app.dart';
import 'infrastructure/database/sqlite_database.dart';

void bootstrapApp() {
  runZonedGuarded(
    () {
      FlutterError.onError = (details) {
        appLogger.e(
          'Flutter framework error',
          error: details.exception,
          stackTrace: details.stack,
        );
      };

      SqliteDatabase.open();
      runApp(const AitelierApp());
    },
    (error, stack) {
      appLogger.f(
        'Uncaught zone error',
        error: error,
        stackTrace: stack,
      );
    },
  );
}
