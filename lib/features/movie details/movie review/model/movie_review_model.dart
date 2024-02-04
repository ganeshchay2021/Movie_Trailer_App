class MovieReviewModel {
  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;

  MovieReviewModel(
      {required this.author,
      required this.authorDetails,
      required this.content,
      required this.createdAt,
      required this.id,
      required this.updatedAt,
      required this.url});

  factory MovieReviewModel.fromMap(Map<String, dynamic> map) {
    return MovieReviewModel(
      author: map['author'],
      authorDetails: AuthorDetails.fromMap(map["author_details"]),
      content: map['content'],
      createdAt: map['created_at'],
      id: map['id'],
      updatedAt: map['updated_at'],
      url: map['url'],
    );
  }
}

class AuthorDetails {
  final String name;
  final String username;
  final String avatarPath;
  final double rating;

  AuthorDetails(
      {required this.name,
      required this.username,
      required this.rating,
      required this.avatarPath});

  factory AuthorDetails.fromMap(Map<String, dynamic> map) {
    return AuthorDetails(
        name: map['name'] ?? "Justin",
        username: map['username'] ?? "justin Marve",
        avatarPath: map['avatar_path'] ?? "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg",
        rating: map['rating'] ?? 0);
  }
}
