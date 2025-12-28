class ProjectId {
  final String value;

  ProjectId(this.value) {
    if (value.isEmpty) {
      throw ArgumentError('ProjectId cannot be empty');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectId && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
