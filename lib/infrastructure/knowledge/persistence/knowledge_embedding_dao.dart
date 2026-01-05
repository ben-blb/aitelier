import 'package:aitelier/core/database/app_database.dart';
import 'package:aitelier/core/database/tables/knowledge_embeddings_table.dart';
import 'package:aitelier/domain/entities/embeddings/knowledge_embedding.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/domain/value_objects/embedding_version.dart';
import 'package:drift/drift.dart';

part 'knowledge_embedding_dao.g.dart';

@DriftAccessor(tables: [KnowledgeEmbeddingsTable])
class KnowledgeEmbeddingDao
    extends DatabaseAccessor<AppDatabase>
    with _$KnowledgeEmbeddingDaoMixin {
  KnowledgeEmbeddingDao(super.db);

  Future<void> upsert(KnowledgeEmbedding embedding) {
    return into(knowledgeEmbeddingsTable).insertOnConflictUpdate(
      KnowledgeEmbeddingsTableCompanion.insert(
        chunkId: embedding.chunkId.value,
        version: embedding.version.value,
        model: embedding.model,
        createdAt: embedding.createdAt,
      ),
    );
  }

  Future<KnowledgeEmbedding?> findByChunkId(ChunkId id) async {
    final row = await (select(knowledgeEmbeddingsTable)
          ..where((tbl) => tbl.chunkId.equals(id.value)))
        .getSingleOrNull();

    if (row == null) return null;

    return KnowledgeEmbedding(
      chunkId: ChunkId.fromString(row.chunkId),
      version: EmbeddingVersion(row.version),
      model: row.model,
      createdAt: row.createdAt,
    );
  }
}
