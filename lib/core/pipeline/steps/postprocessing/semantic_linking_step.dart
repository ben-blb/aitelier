import 'package:aitelier/core/pipeline/pipeline_step_handler.dart';
import 'package:aitelier/core/utils/logger.dart';
import 'package:aitelier/domain/entities/pipeline/pipeline_context.dart';

class SemanticLinkingStep implements PipelineStepHandler {
  @override
  String get stepId => 'post.semantic_linking';

  @override
  Future<PipelineContext> execute(PipelineContext context) async {
    appLogger.d('[SemanticLinkingStep] Starting execution');

    final artifacts = context.metadata['artifacts'];
    final semanticResults = context.metadata['semantic_results'];

    if (artifacts is! List) {
      appLogger.w(
        '[SemanticLinkingStep] No artifacts found in pipeline metadata',
      );
      return context;
    }

    if (semanticResults is! List) {
      appLogger.w(
        '[SemanticLinkingStep] No semantic_results found in pipeline metadata',
      );
      return context;
    }

    int totalLinks = 0;

    final updatedArtifacts = artifacts.map((artifact) {
      if (artifact is! Map<String, dynamic>) {
        appLogger.w(
          '[SemanticLinkingStep] Artifact is not a Map, skipping',
        );
        return artifact;
      }

      final artifactContent = artifact['content']?.toString() ?? '';
      final artifactMetadata =
          Map<String, dynamic>.from(artifact['metadata'] ?? {});

      final linkedResults = semanticResults.where((result) {
        if (result is! Map<String, dynamic>) return false;

        final sourceId = result['sourceId'];
        if (sourceId == null) return false;

        return artifactContent.contains(sourceId.toString());
      }).toList();

      if (linkedResults.isNotEmpty) {
        totalLinks += linkedResults.length;

        appLogger.d(
          '[SemanticLinkingStep] Linked ${linkedResults.length} '
          'semantic results to artifact ${artifact['id'] ?? '(no id)'}',
        );
      }

      artifactMetadata['semantic_refs'] = linkedResults;

      return {
        ...artifact,
        'metadata': artifactMetadata,
      };
    }).toList();

    appLogger.i(
      '[SemanticLinkingStep] Semantic linking completed — '
      '$totalLinks links created across ${updatedArtifacts.length} artifacts',
    );

    final updatedMetadata = Map<String, dynamic>.from(context.metadata)
      ..['artifacts'] = updatedArtifacts;

    return context.copyWith(metadata: updatedMetadata);
  }
}
