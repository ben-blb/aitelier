import 'package:aitelier/core/pipeline/pipeline_registry.dart';
import 'package:aitelier/core/pipeline/steps/postprocessing/artifact_enrichment_step.dart';
import 'package:aitelier/core/pipeline/steps/postprocessing/chunking_step.dart';
import 'package:aitelier/core/pipeline/steps/postprocessing/output_normalization_step.dart';
import 'package:aitelier/core/pipeline/steps/postprocessing/semantic_linking_step.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/context_retrieval_step.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/entity_extraction_step.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/intent_classification_step.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/semantic_search_step.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final pipelineRegistryProvider = Provider<PipelineRegistry>((ref) {
  final registry = PipelineRegistry();

  registry.register(ContextRetrievalStep());
  registry.register(IntentClassificationStep());
  registry.register(EntityExtractionStep());

  registry.register(
    SemanticSearchStep(ref),
  );

  registry.register(SemanticLinkingStep());

  registry.register(OutputNormalizationStep());
  registry.register(ChunkingStep());
  registry.register(ArtifactEnrichmentStep());

  return registry;
});
