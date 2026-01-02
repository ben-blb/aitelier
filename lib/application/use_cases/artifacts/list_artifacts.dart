import 'package:aitelier/core/utils/logger.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:aitelier/infrastructure/artifacts/models/artifact_summary.dart';

import '../../../infrastructure/artifacts/index/artifact_lookup_service.dart';

class ListArtifacts {
  final ArtifactLookupService lookup;

  ListArtifacts({required this.lookup});

  Future<List<ArtifactSummary>> call(ProjectId projectId) {
    appLogger.i('Loading artifacts project ${projectId.value}');
    return lookup.listAll(projectId);
  }
}
