import 'dart:async';
import 'package:flutter/material.dart';

import 'core/utils/logger.dart';
import 'app.dart';

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
