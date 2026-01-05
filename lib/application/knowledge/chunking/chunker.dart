abstract class Chunker {
  List<ChunkSlice> split(String text);
}

class ChunkSlice {
  final int start;
  final int end;

  ChunkSlice(this.start, this.end);
}
