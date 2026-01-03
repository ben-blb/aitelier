import 'package:aitelier/core/database/app_database.dart';
import 'package:aitelier/domain/repositories/pipeline_purpose_repository.dart';
import 'package:aitelier/infrastructure/pipeline/models/pipeline_purpose_dao.dart';

class PipelinePurposeRepositoryImpl
    implements PipelinePurposeRepository {
  final PipelinePurposeDao dao;

  PipelinePurposeRepositoryImpl(this.dao);

  @override
  Future<String?> getPipelineForPurpose(String purpose) async {
    final row = await dao.getByPurpose(purpose);
    return row?.pipelineId;
  }

  @override
  Future<void> assignPipeline(
    String purpose,
    String pipelineId,
  ) {
    return dao.upsert(
      PipelinePurposeTableData(
        purpose: purpose,
        pipelineId: pipelineId,
      ),
    );
  }
}
