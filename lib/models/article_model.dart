import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String docId;
  final int userId;
  final String title;
  final String subtitle;
  final String content;
  final List comment;
  final List like;
  final int countlike;
  final int countComment;
  final String urlImage;
  final String updatedAt;

  ArticleModel({
    required this.docId,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.comment,
    required this.like,
    required this.countlike,
    required this.countComment,
    required this.urlImage,
    required this.updatedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json, String docId) {
    return ArticleModel(
      docId: docId,
      userId: json['idUser'],
      title: json['subtitle'],
      subtitle: json['title'],
      content: json['content'],
      comment: json['comment'],
      like: json['idlike'],
      countlike: json['countlike'],
      countComment: json['countcomment'],
      urlImage: json['urlimage'],
      updatedAt: json['updated_at'],
    );
  }

  static List<ArticleModel> fromJsonList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String docId = doc.id;
      return ArticleModel.fromJson(data, docId);
    }).toList();
  }
}
