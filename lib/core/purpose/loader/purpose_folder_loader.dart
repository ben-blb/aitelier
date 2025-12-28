import 'dart:convert';
import 'package:flutter/services.dart';
import '../../utils/logger.dart';
import './purpose_loader.dart';
import './purpose_registry.dart';

class PurposeFolderLoader {
  static Future<void> loadAllFromFolder({
    required String folderPath,
    required PurposeRegistry registry,
  }) async {
    appLogger.i('Loading purposes from folder: $folderPath');

    final manifestContent =
        await rootBundle.loadString('AssetManifest.json');
    final manifestMap =
        jsonDecode(manifestContent) as Map<String, dynamic>;

    final purposeFiles = manifestMap.keys
        .where(
          (path) =>
              path.startsWith(folderPath) && path.endsWith('.json'),
        )
        .toList();

    if (purposeFiles.isEmpty) {
      appLogger.w('No purpose files found in $folderPath');
    }

    for (final path in purposeFiles) {
      try {
        appLogger.i('Loading purpose file: $path');
        final purpose = await PurposeLoader.loadFromAsset(path);
        registry.register(purpose);
      } catch (e, stack) {
        appLogger.e(
          'Failed to load purpose from $path',
          error: e,
          stackTrace: stack,
        );
        rethrow;
      }
    }

    appLogger.i(
      'Loaded ${registry.listAll().length} purposes successfully',
    );
  }
}
