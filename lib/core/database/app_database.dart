import 'dart:io';
import 'package:aitelier/core/database/tables/knowledge_chunks_table.dart';
import 'package:aitelier/core/database/tables/knowledge_embeddings_table.dart';
import 'package:aitelier/core/database/tables/llm_settings_table.dart';
import 'package:aitelier/core/database/tables/pipeline_purpose_table.dart';
import 'package:aitelier/core/database/tables/pipeline_tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/conversations_table.dart';

part 'app_database.g.dart';
@DriftDatabase(tables: [Conversations, LlmSettingsTable, PipelinesTable, PipelinePurposeTable, KnowledgeChunksTable, KnowledgeEmbeddingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'aitelier.sqlite'));
    return NativeDatabase(file);
  });
}
