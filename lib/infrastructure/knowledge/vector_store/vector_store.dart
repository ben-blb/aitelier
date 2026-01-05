abstract class VectorStore {
  Future<void> upsert({
    required String id,
    required List<double> vector,
    required Map<String, dynamic> metadata,
  });

  Future<void> delete(String id);
}
