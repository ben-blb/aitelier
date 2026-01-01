class ArtifactOrigin {
  final String conversationId;
  final String purpose;
  final String? parentArtifactId;

  ArtifactOrigin({
    required this.conversationId,
    required this.purpose,
    this.parentArtifactId
  });
}
