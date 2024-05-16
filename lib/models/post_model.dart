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
      idPost: json['post'][0]['id'],
      userId: json['post'][0]['user_id'],
      caption: json['post'][0]['caption'],
      url: json['post'][0]['urlimage'],
      countLike: json['post'][0]['countlike'],
      countComment: json['post'][0]['countcomment'],
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
    developer.log(json['like'].toString(), name: 'json response');
    return LikeModel(
      id: json['like'][0]['id'],
      userId: json['like'][0]['user_id'],
      postId: json['like'][0]['post_id'],
    );
  }
}
