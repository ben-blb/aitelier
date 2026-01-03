import 'package:aitelier/domain/entities/artifacts/artifact.dart';

abstract class ArtifactRepository {
  Future<void> save(Artifact artifact, String content);
}
