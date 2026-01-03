class Pipeline {
  final String id;
  final String name;
  final List<String> stepIds;
  final bool enabled;

  Pipeline({
    required this.id,
    required this.name,
    required this.stepIds,
    required this.enabled,
  });
}
