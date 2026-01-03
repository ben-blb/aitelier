abstract class PipelinePurposeRepository {
  Future<String?> getPipelineForPurpose(String purpose);
  Future<void> assignPipeline(String purpose, String pipelineId);
}
