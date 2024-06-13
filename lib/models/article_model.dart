import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String docId;
  final int userId;
  final String title;
  final String subtitle;
  final String content;
  final List<CommentModel> comments;
  // final Map<String, dynamic> like;
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
    required this.comments,
    // required this.like,
    required this.countlike,
    required this.countComment,
    required this.urlImage,
    required this.updatedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json, String docId) {
    List<dynamic> commentsJson = json['comment'];
    List<CommentModel> commentsList = CommentModel.fromJsonList(commentsJson);

    return ArticleModel(
      docId: docId,
      userId: json['idUser'],
      title: json['title'],
      subtitle: json['subtitle'],
      content: json['content'],
      comments: commentsList,
      // like: json['idlike'],
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

class CommentModel {
  final String comment;
  final String createdAt;

  CommentModel({required this.comment, required this.createdAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comment: json['comment'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'created_at': createdAt,
    };
  }

  static List<CommentModel> fromJsonList(List<dynamic> jsonMap) {
    return jsonMap.map((entry) {
      Map<String, dynamic> commentData = entry as Map<String, dynamic>;
      return CommentModel.fromJson(commentData);
    }).toList();
  }
}
