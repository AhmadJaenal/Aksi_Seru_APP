import 'dart:developer' as developer;

class PostModel {
  final int idPost;
  final int userId;
  final String caption;
  final String url;
  final int countLike;
  final int countComment;

  PostModel({
    required this.idPost,
    required this.userId,
    required this.caption,
    required this.url,
    required this.countLike,
    required this.countComment,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      idPost: json['id'],
      userId: json['user_id'],
      caption: json['caption'],
      url: json['urlimage'],
      countLike: json['countlike'],
      countComment: json['countcomment'],
    );
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

class CommentModel {
  final int id;
  final int userId;
  final int postId;
  final String comment;

  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.comment,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      userId: json['user_id'] ?? 0,
      postId: json['post_id'] ?? 0,
      comment: json['comment'],
    );
  }

  static List<CommentModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CommentModel.fromJson(json)).toList();
  }
}
