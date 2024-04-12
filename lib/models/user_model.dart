class UserModel {
  final String id;
  final String username;
  final String name;
  final int countPost;
  final int countArticle;
  final int followers;
  final int following;
  final String bio;
  final int idPost;
  final int idArticle;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.countPost,
    required this.countArticle,
    required this.followers,
    required this.following,
    required this.bio,
    required this.idPost,
    required this.idArticle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      countPost: json['countPost'],
      countArticle: json['countArticle'],
      followers: json['followers'],
      following: json['following'],
      bio: json['bio'],
      idPost: json['idPost'],
      idArticle: json['idArticle'],
    );
  }
}
