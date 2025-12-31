
import 'dart:io';

import 'package:aitelier/core/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Database must be overridden in bootstrap');
});

final projectsRootProvider = Provider<Directory>((ref) {
  throw UnimplementedError('Projects root must be overridden in bootstrap');
});
