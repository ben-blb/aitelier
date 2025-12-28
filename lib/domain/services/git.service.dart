abstract class GitService {
  Future<void> initRepository(String path);
  Future<void> commitAll(String path, String message);
}
