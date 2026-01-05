import '../../../application/knowledge/chunking/chunker.dart';

/// A very simple, deterministic semantic splitter.
///
/// Strategy:
/// - Split by paragraphs (double newline)
/// - Enforce max character length per chunk
/// - Preserve character offsets for traceability
///
/// This is intentionally naive:
/// - Easy to reason about
/// - Easy to replace later (LLM-based, token-based, etc.)
class SimpleSemanticSplitter implements Chunker {
  static const int _maxChunkSize = 800; // chars

  @override
  List<ChunkSlice> split(String text) {
    if (text.trim().isEmpty) {
      return const [];
    }

    final slices = <ChunkSlice>[];

    int cursor = 0;

    // Split by paragraphs first
    final paragraphs = text.split(RegExp(r'\n\s*\n'));

    for (final paragraph in paragraphs) {
      final paragraphStart = text.indexOf(paragraph, cursor);
      final paragraphEnd = paragraphStart + paragraph.length;

      // If paragraph fits, take it whole
      if (paragraph.length <= _maxChunkSize) {
        slices.add(
          ChunkSlice(paragraphStart, paragraphEnd),
        );
      } else {
        // Otherwise, hard-split by max size
        int localStart = paragraphStart;

        while (localStart < paragraphEnd) {
          final localEnd =
              (localStart + _maxChunkSize).clamp(localStart, paragraphEnd);

          slices.add(
            ChunkSlice(localStart, localEnd),
          );

          localStart = localEnd;
        }
      }

      cursor = paragraphEnd;
    }

    return slices;
  }
}
