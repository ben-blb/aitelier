import 'dart:io';
import '../../../domain/entities/artifacts/artifact.dart';
import '../../../domain/repositories/artifact_repository.dart';

class FileArtifactRepository implements ArtifactRepository {
  final Directory root;

  FileArtifactRepository(this.root);

  @override
  Future<void> save(Artifact artifact, String content) async {
    final dir = Directory('${root.path}/artifacts/${artifact.id}');
    await dir.create(recursive: true);

    final meta = File('${dir.path}/meta.json');
    final body = File('${dir.path}/content.md');

    await meta.writeAsString(artifact.toString());
    await body.writeAsString(content);
  }
}
