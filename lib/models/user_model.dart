import "dart:developer" as developer;

class UserModel {
  final String username;
  final String name;
  final String email;
  final String avatar;
  final int countPost;
  final int countArticle;
  final int followers;
  final int following;
  final String bio;
  // final int idPost;
  // final int idArticle;

  const UserModel({
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.countPost,
    required this.countArticle,
    required this.followers,
    required this.following,
    required this.bio,
    // required this.idPost,
    // required this.idArticle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'].toString(),
      name: json['full_name'].toString(),
      email: json['email'].toString(),
      avatar: json['avatar'] != null ? json['avatar'].toString() : '',
      countPost: json['count_post'],
      countArticle: json['count_article'],
      followers: json['followers'],
      following: json['following'],
      bio: json['bio'] != null ? json['bio'].toString() : '',
      // idPost: json['idPost'],
      // idArticle: json['idArticle'],
    );
  }
}
