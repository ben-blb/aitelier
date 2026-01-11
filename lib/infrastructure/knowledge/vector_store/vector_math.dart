import 'dart:math';
import 'dart:typed_data';
// SQLite vss later
double cosineSimilarity(Float64List a, Float64List b) {
  double dot = 0.0;
  double normA = 0.0;
  double normB = 0.0;

  for (int i = 0; i < a.length; i++) {
    dot += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }

  return dot / (sqrt(normA) * sqrt(normB));
}
