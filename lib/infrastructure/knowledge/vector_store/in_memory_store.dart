import 'package:aitelier/infrastructure/knowledge/vector_store/vector_store.dart';

class InMemoryVectorStore implements VectorStore {
  final Map<String, List<double>> _store = {};

  @override
  Future<void> upsert({
    required String id,
    required List<double> vector,
    required Map<String, dynamic> metadata,
  }) async {
    _store[id] = vector;
  }

  @override
  Future<void> delete(String id) async {
    _store.remove(id);
  }
}
