import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String docId;
  final String email;
  final String caption;
  final String urlImage;
  final String updatedAt;
  final List<CommentPostModel> comments;
  final List<LikeModel> likes;

  PostModel({
    required this.docId,
    required this.email,
    required this.caption,
    required this.urlImage,
    required this.updatedAt,
    required this.comments,
    required this.likes,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String docId) {
    List<dynamic> commentsJson = json['comment'];
    List<CommentPostModel> commentsList =
        CommentPostModel.fromJsonList(commentsJson);

    List<dynamic> likesJson = json['likes'];
    List<LikeModel> likesList = LikeModel.fromJsonList(likesJson);

    return PostModel(
      docId: docId,
      email: json['email'],
      caption: json['caption'],
      urlImage: json['urlimage'],
      updatedAt: json['updated_at'],
      comments: commentsList,
      likes: likesList,
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

class CommentPostModel {
  String idComment;
  CommentPostModel({required this.idComment});

  factory CommentPostModel.fromJson(Map<String, dynamic> json) {
    return CommentPostModel(
      idComment: json['id_comment'],
    );
  }

  static List<CommentPostModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CommentPostModel.fromJson(json)).toList();
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

class LikeModel {
  final String email;

  LikeModel({
    required this.email,
  });
  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      email: json['email'],
    );
  }

  static List<LikeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LikeModel.fromJson(json)).toList();
  }
}
