import 'package:aitelier/domain/entities/pipeline/pipeline.dart';
import 'package:aitelier/domain/repositories/pipeline_purpose_repository.dart';
import 'package:aitelier/domain/repositories/pipeline_repository.dart';

class PipelineResolver {
  final PipelineRepository pipelineRepository;
  final PipelinePurposeRepository purposeRepository;

  PipelineResolver({
    required this.pipelineRepository,
    required this.purposeRepository,
  });

  Future<Pipeline?> resolveForPurpose(String purpose) async {
    final pipelineId =
        await purposeRepository.getPipelineForPurpose(purpose);

    if (pipelineId == null) return null;

    return pipelineRepository.getById(pipelineId);
  }
}
