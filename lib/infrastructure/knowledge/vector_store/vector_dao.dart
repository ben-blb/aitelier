import 'dart:convert';
import 'dart:typed_data';
import 'package:aitelier/core/database/tables/vector_table.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

part 'vector_dao.g.dart';

@DriftAccessor(tables: [VectorTable])
class VectorDao extends DatabaseAccessor<AppDatabase>
    with _$VectorDaoMixin {
  VectorDao(super.db);

  Future<void> upsert({
    required String id,
    required Float64List vector,
    required Map<String, dynamic> metadata,
  }) {
    return into(vectorTable).insertOnConflictUpdate(
      VectorTableCompanion.insert(
        id: id,
        vector: vector.buffer.asUint8List(),
        metadata: jsonEncode(metadata),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<VectorTableData>> getAll() {
    return select(vectorTable).get();
  }

  Future<void> deleteById(String id) {
    return (delete(vectorTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
