import 'package:aitelier/domain/entities/artifacts/artifact_origin.dart';
import 'package:aitelier/domain/entities/artifacts/artifact_timestamps.dart';
import 'package:aitelier/domain/entities/artifacts/artifact_type.dart';
import 'package:aitelier/domain/entities/artifacts/artifact_version.dart';

class Artifact {
  final String id; // ULID
  final ArtifactType type;
  final ArtifactOrigin origin;
  final ArtifactTimestamps timestamps;
  final ArtifactVersion version;

  final String title;
  final List<String> tags;

  final bool isGeneric;

  Artifact({
    required this.id,
    required this.type,
    required this.origin,
    required this.timestamps,
    required this.version,
    required this.title,
    this.tags = const [],
    this.isGeneric = false,
  });
}
