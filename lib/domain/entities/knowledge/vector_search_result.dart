class VectorSearchResult {
  final String id;
  final double score;
  final Map<String, dynamic> metadata;

  VectorSearchResult({
    required this.id,
    required this.score,
    required this.metadata,
  });
}
