import 'package:aitelier/core/database/tables/knowledge_chunks_table.dart';
import 'package:aitelier/domain/entities/knowledge/chunk_metadata.dart';
import 'package:aitelier/domain/entities/knowledge/chunk_source.dart';
import 'package:aitelier/domain/entities/knowledge/knowledge_chunk.dart';
import 'package:aitelier/domain/value_objects/chunk_id.dart';
import 'package:aitelier/domain/value_objects/chunk_version.dart';
import 'package:aitelier/domain/value_objects/project_id.dart';
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

part 'knowledge_chunk_dao.g.dart';

@DriftAccessor(tables: [KnowledgeChunksTable])
class KnowledgeChunkDao extends DatabaseAccessor<AppDatabase>
    with _$KnowledgeChunkDaoMixin {
  KnowledgeChunkDao(super.db);

  // ------------------------------------------------------------
  // INSERT
  // ------------------------------------------------------------

  Future<void> insertAll(List<KnowledgeChunk> chunks) async {
    await batch((batch) {
      batch.insertAll(
        knowledgeChunksTable,
        chunks.map(_toCompanion).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // ------------------------------------------------------------
  // QUERIES
  // ------------------------------------------------------------

  Future<List<KnowledgeChunk>> findBySource(
    ProjectId projectId,
    ChunkSource source,
    String sourceId,
  ) async {
    final rows = await (select(knowledgeChunksTable)
          ..where((tbl) =>
              tbl.projectId.equals(projectId.value) &
              tbl.source.equals(source.name) &
              tbl.sourceId.equals(sourceId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]))
        .get();

    return rows.map(_fromRow).toList();
  }

  Future<void> deleteBySource(
    ProjectId projectId,
    ChunkSource source,
    String sourceId,
  ) {
    return (delete(knowledgeChunksTable)
          ..where((tbl) =>
              tbl.projectId.equals(projectId.value) &
              tbl.source.equals(source.name) &
              tbl.sourceId.equals(sourceId)))
        .go();
  }

  Future<KnowledgeChunk?> findById(ChunkId id) async {
    final row = await (select(knowledgeChunksTable)
          ..where((tbl) => tbl.id.equals(id.value)))
        .getSingleOrNull();

    if (row == null) return null;

    return _fromRow(row);
  }

  // ------------------------------------------------------------
  // MAPPERS
  // ------------------------------------------------------------

  KnowledgeChunksTableCompanion _toCompanion(KnowledgeChunk chunk) {
    return KnowledgeChunksTableCompanion.insert(
      id: chunk.id.value,
      projectId: chunk.metadata.projectId.value,
      source: chunk.metadata.source.name,
      sourceId: chunk.metadata.sourceId,
      position: chunk.metadata.position,
      charStart: chunk.charStart,
      charEnd: chunk.charEnd,
      version: chunk.version.value,
      createdAt: chunk.createdAt,
    );
  }

  KnowledgeChunk _fromRow(KnowledgeChunksTableData row) {
    return KnowledgeChunk(
      id: ChunkId.fromString(row.id),
      metadata: ChunkMetadata(
        projectId: ProjectId(row.projectId),
        source: ChunkSource.values.byName(row.source),
        sourceId: row.sourceId,
        position: row.position,
      ),
      version: ChunkVersion(row.version),
      charStart: row.charStart,
      charEnd: row.charEnd,
      createdAt: row.createdAt,
    );
  }
}
