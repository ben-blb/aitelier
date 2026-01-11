import 'dart:convert';
import 'dart:typed_data';

import 'package:aitelier/domain/entities/knowledge/vector_search_result.dart';
import 'package:aitelier/infrastructure/knowledge/vector_store/vector_store.dart';

import 'vector_dao.dart';
import 'vector_math.dart';

class SqliteVectorStore implements VectorStore {
  final VectorDao dao;

  SqliteVectorStore(this.dao);

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
    return dao.deleteById(id);
  }

  @override
  Future<List<VectorSearchResult>> search({
    required List<double> query,
    int limit = 10,
    double minScore = 0.0,
  }) async {
    final queryVector = Float64List.fromList(query);
    final rows = await dao.getAll();

    final results = <VectorSearchResult>[];

    for (final row in rows) {
      final vector =
          Float64List.view(row.vector.buffer);
      final score = cosineSimilarity(queryVector, vector);

      if (score >= minScore) {
        results.add(
          VectorSearchResult(
            id: row.id,
            score: score,
            metadata: jsonDecode(row.metadata),
          ),
        );
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));

    return results.take(limit).toList();
  }
}
