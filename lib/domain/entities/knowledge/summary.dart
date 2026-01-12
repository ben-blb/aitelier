enum SummaryScope {
  conversation,
  project,
}

class Summary {
  final String id;
  final SummaryScope scope;
  final String scopeId;
  final String content;
  final int version;
  final DateTime updatedAt;

  Summary({
    required this.id,
    required this.scope,
    required this.scopeId,
    required this.content,
    required this.version,
    required this.updatedAt,
  });
}
