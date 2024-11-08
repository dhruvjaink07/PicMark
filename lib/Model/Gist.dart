class Gist {
  final String id;
  final String description;
  final String htmlUrl;
  final String createdAt;
  final String updatedAt;
  final String ownerName;
  final Map<String, dynamic> files;
  final Map<String, dynamic> owner;
  final int commentCount;
  Gist({
    required this.id,
    required this.description,
    required this.htmlUrl,
    required this.createdAt,
    required this.ownerName,
    required this.files,
    required this.owner,
    required this.updatedAt,
    required this.commentCount
  });

  factory Gist.fromJson(Map<String, dynamic> json) {
    return Gist(
      id: json['id'],
      description: json['description'] ?? 'No description',
      htmlUrl: json['html_url'],
      createdAt: json['created_at'],
      ownerName: json['owner']['login'],
      files: json['files'],
      owner: json['owner'],
      updatedAt: json['updated_at'],
      commentCount: json['comments']
    );
  }
}
