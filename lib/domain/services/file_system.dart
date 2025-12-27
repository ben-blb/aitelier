abstract class FileSystem {
  Future<bool> exists(String path);
  Future<void> createDirectory(String path);
  Future<String> readFile(String path);
  Future<void> writeFileAtomic(String path, String contents);
  Future<void> deleteDirectory(String path);
}
