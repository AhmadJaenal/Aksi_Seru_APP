import 'dart:developer' as developer;

import 'package:aksi_seru_app/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String docId;
  final String email;
  final String caption;
  final String urlImage;
  final String updatedAt;
  final List<CommentModel> comments;

  PostModel({
    required this.docId,
    required this.email,
    required this.caption,
    required this.urlImage,
    required this.updatedAt,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String docId) {
    List<dynamic> commentsJson = json['comment'];
    List<CommentModel> commentsList = CommentModel.fromJsonList(commentsJson);

    return PostModel(
      docId: docId,
      email: json['email'],
      caption: json['caption'],
      urlImage: json['urlimage'],
      updatedAt: json['updated_at'],
      comments: commentsList,
    );
  }

  static List<PostModel> fromJsonList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String docId = doc.id;

      return PostModel.fromJson(data, docId);
    }).toList();
  }
}

class LikeModel {
  final int id;
  final int userId;
  final int postId;

  LikeModel({
    required this.id,
    required this.userId,
    required this.postId,
  });
  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      userId: json['user_id'],
      postId: json['post_id'],
    );
  }

  static List<LikeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LikeModel.fromJson(json)).toList();
  }
}
