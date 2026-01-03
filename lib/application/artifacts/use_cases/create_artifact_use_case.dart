import 'package:aitelier/domain/entities/artifacts/artifact.dart';
import 'package:aitelier/domain/repositories/artifact_repository.dart';

class CreateArtifactUseCase {
  final ArtifactRepository repository;

  CreateArtifactUseCase(this.repository);

  Future<void> execute({
    required Artifact artifact,
    required String content,
  }) {
    return repository.save(artifact, content);
  }
}
