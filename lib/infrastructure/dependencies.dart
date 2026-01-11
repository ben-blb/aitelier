import 'dart:io';

import 'package:aitelier/application/artifacts/processors/generic_artifact_processor.dart';
import 'package:aitelier/core/dependencies.dart';
import 'package:aitelier/domain/repositories/knowledge_embedding_repository.dart';
import 'package:aitelier/domain/services/conversation_git_hook.dart';
import 'package:aitelier/domain/services/secret_storage.dart';
import 'package:aitelier/infrastructure/artifacts/index/artifact_index_service.dart';
import 'package:aitelier/infrastructure/artifacts/index/artifact_lookup_service.dart';
import 'package:aitelier/infrastructure/artifacts/index/conversation_index_service.dart';
import 'package:aitelier/infrastructure/artifacts/provenance/artifact_provenance_service.dart';
import 'package:aitelier/infrastructure/artifacts/provenance/lineage_index_service.dart';
import 'package:aitelier/infrastructure/artifacts/provenance/purpose_index_service.dart';
import 'package:aitelier/infrastructure/artifacts/repositories/file_artifact_repository.dart';
import 'package:aitelier/infrastructure/artifacts/storage/artifact_file_reader.dart';
import 'package:aitelier/infrastructure/artifacts/storage/artifact_file_writer.dart';
import 'package:aitelier/infrastructure/artifacts/storage/artifact_storage_service.dart';
import 'package:aitelier/infrastructure/conversations/drift_conversation_repository.dart';
import 'package:aitelier/infrastructure/conversations/models/conversation_dao.dart';
import 'package:aitelier/infrastructure/git/conversation_git_hook.dart';
import 'package:aitelier/infrastructure/git/local_git_service.dart';
import 'package:aitelier/infrastructure/knowledge/persistence/knowledge_embedding_dao.dart';
import 'package:aitelier/infrastructure/knowledge/persistence/sqlite_knowledge_embedding_repository.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/sqlite_vector_store.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/sqlite_vss/sqlite_vss_vector_store.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/sqlite_vss/vss_capability_detector.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/sqlite_vss/vss_vector_dao.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/vector_dao.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/vector_store.dart';
import 'package:aitelier/infrastructure/pipeline/models/pipeline_dao.dart';
import 'package:aitelier/infrastructure/pipeline/models/pipeline_purpose_dao.dart';
import 'package:aitelier/infrastructure/pipeline/pipeline_purpose_repository_impl.dart';
import 'package:aitelier/infrastructure/pipeline/pipeline_repository_impl.dart';
import 'package:aitelier/infrastructure/security/secure_storage_adapter.dart';
import 'package:aitelier/infrastructure/storage/file_conversation_store.dart';
import 'package:aitelier/infrastructure/storage/local_file_system.dart';
import 'package:aitelier/infrastructure/storage/local_project_repository.dart';
import 'package:aitelier/infrastructure/storage/local_workspace_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localFileSystemProvider = Provider<LocalFileSystem>((ref) {
  return LocalFileSystem();
});

// We assume this provider is overridden in bootstrap with getApplicationSupportDirectory()
final appSupportDirProvider = Provider<Directory>((ref) {
  throw UnimplementedError('Must override appSupportDirProvider in bootstrap');
});

final localWorkspaceStorageProvider = Provider<LocalWorkspaceStorage>((ref) {
  final fs = ref.watch(localFileSystemProvider);
  final rootDir = ref.watch(appSupportDirProvider);
  
  return LocalWorkspaceStorage(
    fs: fs,
    basePath: rootDir.path, 
  );
});

final projectRepositoryProvider = Provider<LocalProjectRepository>((ref) {
  return LocalProjectRepository(
    fs: ref.watch(localFileSystemProvider),
    workspaceStorage: ref.watch(localWorkspaceStorageProvider),
  );
});

final gitServiceProvider = Provider<LocalGitService>((ref) {
  return LocalGitService();
});

final conversationDaoProvider = Provider((ref) {
  return ConversationDao(ref.watch(appDatabaseProvider));
});

final conversationRepoProvider = Provider<DriftConversationRepository>((ref) {
  return DriftConversationRepository(ref.watch(conversationDaoProvider));
});

final fileConversationStoreProvider = Provider<FileConversationStore>((ref) {
  return FileConversationStore(ref.watch(projectsRootProvider));
});

final conversationGitHookProvider = Provider<ConversationGitHook>((ref) {
  return LocalConversationGitHook(
    root: ref.watch(projectsRootProvider),
    git: ref.watch(gitServiceProvider),
  );
});

final artifactFileWriterProvider =
    Provider<ArtifactFileWriter>((ref) {
  return ArtifactFileWriter(
    ref.watch(projectsRootProvider),
  );
});

final artifactFileReaderProvider =
    Provider<ArtifactFileReader>((ref) {
  return ArtifactFileReader(
    ref.watch(projectsRootProvider),
  );
});

final artifactIndexServiceProvider =
    Provider<ArtifactIndexService>((ref) {
  return ArtifactIndexService(
    ref.watch(projectsRootProvider),
  );
});

final conversationIndexServiceProvider =
    Provider<ConversationIndexService>((ref) {
  return ConversationIndexService(
    ref.watch(projectsRootProvider),
  );
});

final artifactStorageServiceProvider =
    Provider<ArtifactStorageService>((ref) {
  return ArtifactStorageService(
    writer: ref.watch(artifactFileWriterProvider),
    reader: ref.watch(artifactFileReaderProvider),
    artifactIndex: ref.watch(artifactIndexServiceProvider),
    conversationIndex: ref.watch(conversationIndexServiceProvider),
  );
});

final artifactProvenanceServiceProvider =
    Provider<ArtifactProvenanceService>((ref) {
  return ArtifactProvenanceService(
    ref.watch(projectsRootProvider),
  );
});

final purposeIndexServiceProvider =
    Provider<PurposeIndexService>((ref) {
  return PurposeIndexService(
    ref.watch(projectsRootProvider),
  );
});

final lineageIndexServiceProvider =
    Provider<LineageIndexService>((ref) {
  return LineageIndexService(
    ref.watch(projectsRootProvider),
  );
});

final genericArtifactProcessorProvider =
    Provider<GenericArtifactProcessor>((ref) {
  return GenericArtifactProcessor(
    storage: ref.watch(artifactStorageServiceProvider),
    provenance: ref.watch(artifactProvenanceServiceProvider),
    purposeIndex: ref.watch(purposeIndexServiceProvider)
  );
});

final artifactLookupServiceProvider =
    Provider<ArtifactLookupService>((ref) {
  return ArtifactLookupService(
    ref.watch(projectsRootProvider),
  );
});

final secretStorageProvider = Provider<SecretStorage>((ref) {
  return SecureStorageAdapter();
});

final artifactRepositoryProvider = Provider<FileArtifactRepository>((ref) {
  return FileArtifactRepository(
    ref.watch(projectsRootProvider),
  );
});

final pipelineDaoProvider = Provider<PipelineDao>((ref) {
  return PipelineDao(ref.watch(appDatabaseProvider));
});

final pipelineRepositoryProvider = Provider<PipelineRepositoryImpl>((ref){
  return PipelineRepositoryImpl(ref.watch(pipelineDaoProvider));
});

final pipelinePurposeDaoProvider = Provider<PipelinePurposeDao>((ref) {
  return PipelinePurposeDao(ref.watch(appDatabaseProvider));
});

final pipelinePurposeRepositoryProvider = Provider<PipelinePurposeRepositoryImpl>((ref) {
  return PipelinePurposeRepositoryImpl(ref.watch(pipelinePurposeDaoProvider));
});

final vectorDaoProvider = Provider<VectorDao>((ref) {
  final db = ref.read(appDatabaseProvider);
  return VectorDao(db);
});

final vectorStoreProvider = FutureProvider<VectorStore>((ref) async {
  final db = ref.read(appDatabaseProvider);
  final detector = VssCapabilityDetector(db);

  if (await detector.isAvailable()) {
    return SqliteVssVectorStore(
      VssVectorDao(db),
    );
  }

  // Fallback (pure Dart cosine)
  return SqliteVectorStore(
    ref.read(vectorDaoProvider),
  );
});


final knowledgeEmbeddingRepositoryProvider =
    Provider<KnowledgeEmbeddingRepository>((ref) {
  final db = ref.read(appDatabaseProvider);
  return SqliteKnowledgeEmbeddingRepository(
    KnowledgeEmbeddingDao(db),
  );
});
