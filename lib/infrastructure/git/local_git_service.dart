import 'package:git/git.dart';

import '../../domain/services/git.service.dart';


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
}
