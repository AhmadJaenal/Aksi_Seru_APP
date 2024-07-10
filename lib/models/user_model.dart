import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String name;
  final String email;
  final String avatar;
  final int countPost;
  final int countArticle;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String bio;

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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json['avatar'] != null ? json['avatar'].toString() : '',
      bio: json['bio'] != null ? json['bio'].toString() : '',
      username: json['username'].toString(),
      name: json['full_name'].toString(),
      email: json['email'].toString(),
      countPost: json['count_post'],
      countArticle: json['count_article'],
      followers: json['followers'],
      following: json['following'],
    );
  }

  static List<UserModel> fromJsonList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> user = doc.data() as Map<String, dynamic>;
      return UserModel.fromJson(user);
    }).toList();
  }
}
