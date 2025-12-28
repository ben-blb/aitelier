import 'package:git/git.dart';

import '../../domain/services/git_service.dart';

class LocalGitService implements GitService {
  @override
  Future<void> initRepository(String path) async {
    await GitDir.init(path);
  }

  @override
  Future<void> commitAll(String path, String message) async {
    final git = await GitDir.fromExisting(path);
    await git.runCommand(['add', '.']);
    await git.runCommand(['commit', '-m', message]);
  }

  @override
  Future<void> addRemote(String path, String url) async {
    final git = await GitDir.fromExisting(path);
    await git.runCommand(['remote', 'add', 'origin', url]);
  }

  @override
  Future<void> push(String path) async {
    final git = await GitDir.fromExisting(path);
    await git.runCommand(['push', '-u', 'origin', 'HEAD']);
  }
}
