abstract class GitService {
  Future<void> initRepository(String path);
  Future<void> commitAll(String path, String message);
  Future<void> addRemote(String path, String url);
  Future<void> push(String path);
}
