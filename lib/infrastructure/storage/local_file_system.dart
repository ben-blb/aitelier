import 'dart:io';

import '../../domain/services/file_system.dart';

class LocalFileSystem implements FileSystem {
  @override
  Future<bool> exists(String path) async {
    return FileSystemEntity.typeSync(path) !=
        FileSystemEntityType.notFound;
  }

  @override
  Future<void> createDirectory(String path) async {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  @override
  Future<String> readFile(String path) async {
    return File(path).readAsStringSync();
  }

  @override
  Future<void> writeFileAtomic(String path, String contents) async {
    final temp = File('$path.tmp');
    temp.writeAsStringSync(contents);
    temp.renameSync(path);
  }

  @override
  Future<void> deleteDirectory(String path) async {
    final dir = Directory(path);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }
}
