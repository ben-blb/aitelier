import 'dart:io';
import 'package:aitelier/core/database/tables/knowledge_chunks_table.dart';
import 'package:aitelier/core/database/tables/knowledge_embeddings_table.dart';
import 'package:aitelier/core/database/tables/llm_settings_table.dart';
import 'package:aitelier/core/database/tables/pipeline_purpose_table.dart';
import 'package:aitelier/core/database/tables/pipeline_tables.dart';
import 'package:aitelier/core/database/tables/summaries_table.dart';
import 'package:aitelier/core/database/tables/vector_table.dart';
import 'package:aitelier/core/database/tables/vss_vector_table.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/sqlite_vss/vss_capability_detector.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/conversations_table.dart';

part 'app_database.g.dart';
@DriftDatabase(tables: [
  Conversations,
  LlmSettingsTable,
  PipelinesTable,
  PipelinePurposeTable,
  KnowledgeChunksTable,
  KnowledgeEmbeddingsTable,
  VectorTable,
  SummariesTable
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          // 1️⃣ Create normal Drift tables
          await m.createAll();

          // 2️⃣ Try to create VSS table
          await _initializeVssIfAvailable();
        },
        beforeOpen: (details) async {
          // 3️⃣ Also attempt on open (for existing DBs)
          await _initializeVssIfAvailable();
        },
      );
  
  Future<void> _initializeVssIfAvailable() async {
    final detector = VssCapabilityDetector(this);

    if (await detector.isAvailable()) {
      await customStatement(createVssTableSql);
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'aitelier.sqlite'));
    return NativeDatabase(file);
  });
}
