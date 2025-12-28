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

    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    
    final purposeFiles = manifest
        .listAssets()
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