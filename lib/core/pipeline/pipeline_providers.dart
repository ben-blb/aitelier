import 'package:aitelier/core/pipeline/pipeline_registry.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/context_retrieval_step.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/entity_extraction_step.dart';
import 'package:aitelier/core/pipeline/steps/preprocessing/intent_classification_step.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final pipelineRegistryProvider = Provider<PipelineRegistry>((ref) {
  final registry = PipelineRegistry();

  registry.register(ContextRetrievalStep());
  registry.register(IntentClassificationStep());
  registry.register(EntityExtractionStep());

  return registry;
});
