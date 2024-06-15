import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String docId;
  final int userId;
  final String title;
  final String subtitle;
  final String content;
  final List<CommentArticleModel> comments;
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
    List<CommentArticleModel> commentsList =
        CommentArticleModel.fromJsonList(commentsJson);

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

class CommentArticleModel {
  String idComment;
  CommentArticleModel({required this.idComment});

  factory CommentArticleModel.fromJson(Map<String, dynamic> json) {
    return CommentArticleModel(
      idComment: json['id_comment'],
    );
  }

  static List<CommentArticleModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CommentArticleModel.fromJson(json)).toList();
  }
}

class DetailCommentPost {
  final String comment;
  final String createAt;
  final String email;
  final String postId;

  DetailCommentPost({
    required this.comment,
    required this.createAt,
    required this.email,
    required this.postId,
  });
  factory DetailCommentPost.fromJson(Map<String, dynamic> json) {
    return DetailCommentPost(
      comment: json['comment'],
      email: json['email'],
      postId: json['postId'],
      createAt: json['created_at'],
    );
  }
}
