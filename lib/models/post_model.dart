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
