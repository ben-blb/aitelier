import 'dart:convert';
import 'dart:typed_data';
import 'package:aitelier/core/database/app_database.dart';
import 'package:drift/drift.dart';

class VssVectorDao {
  final AppDatabase db;

  VssVectorDao(this.db);

  Future<void> upsert({
    required String id,
    required Float64List vector,
    required Map<String, dynamic> metadata,
  }) async {
    await db.customStatement(
      '''
      INSERT OR REPLACE INTO vss_vectors (id, embedding, metadata)
      VALUES (?, ?, ?)
      ''',
      [
        id,
        vector.buffer.asUint8List(),
        jsonEncode(metadata),
      ],
    );
  }

  Future<List<Map<String, Object?>>> search({
    required Float64List query,
    required int limit,
  }) async {
    final rows = await db.customSelect(
      '''
      SELECT id, metadata, distance
      FROM vss_vectors
      WHERE vss_search(embedding, ?)
      LIMIT ?
      ''',
      variables: [
        Variable(query.buffer.asUint8List()), 
        Variable(limit),
      ],
    ).get();

    return rows.map((row) {
      return {
        'id': row.read<String>('id'),
        'metadata': row.read<String>('metadata'),
        'distance': row.read<double>('distance'),
      };
    }).toList();
  }


  Future<void> delete(String id) {
    return db.customStatement(
      'DELETE FROM vss_vectors WHERE id = ?',
      [id],
    );
  }
}
