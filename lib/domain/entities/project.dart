class Project {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final String rootPath;
  final String? remoteUrl;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.rootPath,
    this.remoteUrl
  });

  
  Project copyWith({String? remoteUrl}) {
    return Project(
      id: id,
      name: name,
      rootPath: rootPath,
      description: description,
      createdAt: createdAt,
      remoteUrl: remoteUrl ?? this.remoteUrl,
    );
  }
}
