class UserModel {
  final String id;
  final String username;
  final String name;
  final String email;
  final String token;
  final String avatar;
  // final int countPost;
  // final int countArticle;
  // final int followers;
  // final int following;
  final String bio;
  // final int idPost;
  // final int idArticle;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.token,
    required this.avatar,
    // required this.countPost,
    // required this.countArticle,
    // required this.followers,
    // required this.following,
    required this.bio,
    // required this.idPost,
    // required this.idArticle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      username: json['username'].toString(),
      name: json['name'].toString(),
      email: json['email'].toString(),
      token: json['token'].toString(),
      avatar: json['avatar'] != null ? json['avatar'].toString() : '',
      // countPost: json['countPost'],
      // countArticle: json['countArticle'],
      // followers: json['followers'],
      // following: json['following'],
      bio: json['bio'] != null ? json['bio'].toString() : '',
      // idPost: json['idPost'],
      // idArticle: json['idArticle'],
    );
  }
}
