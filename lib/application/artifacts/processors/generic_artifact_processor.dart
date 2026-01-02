import 'package:aitelier/infrastructure/artifacts/models/artifact_processing_input.dart';
import 'package:aitelier/infrastructure/artifacts/models/artifact_processing_result.dart';
import 'package:aitelier/infrastructure/artifacts/provenance/artifact_provenance_service.dart';
import 'package:aitelier/infrastructure/artifacts/provenance/purpose_index_service.dart';
import 'package:ulid/ulid.dart';

import '../../../infrastructure/artifacts/storage/artifact_storage_service.dart';

class GenericArtifactProcessor {
  final ArtifactStorageService storage;
  final Ulid ulid;
  final ArtifactProvenanceService provenance;
  final PurposeIndexService purposeIndex;

  GenericArtifactProcessor({
    required this.storage,
    required this.provenance,
    required this.purposeIndex,
    Ulid? ulid,
  }) : ulid = ulid ?? Ulid();

  Future<ArtifactProcessingResult> process(
    ArtifactProcessingInput input,
  ) async {
    final artifactId = ulid.toString();

    final type = input.contentTypeHint ?? 'text';

    final metadata = {
      'id': artifactId,
      'type': type,
      'title': input.preferredTitle ?? 'Generic Artifact',
      'tags': ['generic', 'auto-captured'],
      'isGeneric': true,
      'origin': {
        'conversationId': input.conversationId,
        'purpose': input.purpose,
        'parentArtifactId': null,
      },
      'timestamps': {
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      },
      'currentVersion': '1.0.0',
    };

    await storage.saveArtifact(
      metadata: metadata,
      content: input.rawOutput,
      artifactId: artifactId,
      version: '1.0.0',
      conversationId: input.conversationId,
      fileExtension: _extensionForType(type),
    );

    return ArtifactProcessingResult(
      artifactId: artifactId,
      isGeneric: true,
      version: '1.0.0',
    );
  }

  String _extensionForType(String type) {
    switch (type) {
      case 'markdown':
        return 'md';
      case 'code':
        return 'txt';
      case 'json':
        return 'json';
      default:
        return 'txt';
    }
  }
}
