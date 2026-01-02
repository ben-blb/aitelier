class ArtifactSummary {
  final String id;
  final String type;
  final String title;
  final String currentVersion;
  final List<String> tags;

  ArtifactSummary({
    required this.id,
    required this.type,
    required this.title,
    required this.currentVersion,
    required this.tags,
  });

  factory ArtifactSummary.fromJson(Map<String, dynamic> json) {
    return ArtifactSummary(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      currentVersion: json['currentVersion'] as String,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
