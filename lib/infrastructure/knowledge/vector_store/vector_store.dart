import 'package:aitelier/domain/entities/knowledge/vector_search_result.dart';

abstract class VectorStore {
  Future<void> upsert({
    required String id,
    required List<double> vector,
    required Map<String, dynamic> metadata,
  });

  Future<void> delete(String id);

  Future<List<VectorSearchResult>> search({
    required List<double> query,
    int limit = 10,
    double minScore = 0.0,
  });
}
