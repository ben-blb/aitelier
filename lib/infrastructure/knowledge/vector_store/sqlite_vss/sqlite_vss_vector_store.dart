import 'dart:convert';
import 'dart:typed_data';

import 'package:aitelier/domain/entities/knowledge/vector_search_result.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/vector_store.dart';

import 'vss_vector_dao.dart';

class SqliteVssVectorStore implements VectorStore {
  final VssVectorDao dao;

  SqliteVssVectorStore(this.dao);

  @override
  Future<void> upsert({
    required String id,
    required List<double> vector,
    required Map<String, dynamic> metadata,
  }) {
    return dao.upsert(
      id: id,
      vector: Float64List.fromList(vector),
      metadata: metadata,
    );
  }

  @override
  Future<void> delete(String id) {
    return dao.delete(id);
  }

  @override
  Future<List<VectorSearchResult>> search({
    required List<double> query,
    int limit = 10,
    double minScore = 0.0,
  }) async {
    final rows = await dao.search(
      query: Float64List.fromList(query),
      limit: limit,
    );

    return rows.map((row) {
      return VectorSearchResult(
        id: row['id'] as String,
        score: 1.0 - (row['distance'] as double),
        metadata: jsonDecode(row['metadata'] as String),
      );
    }).toList();
  }
}
