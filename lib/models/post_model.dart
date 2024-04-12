class PostModel {
  final int idPost;
  final String url;
  final int countLike;
  final int countComment;
  final String date;

  PostModel({
    required this.idPost,
    required this.url,
    required this.countLike,
    required this.countComment,
    required this.date,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      idPost: json['idPost'],
      url: json['url'],
      countLike: json['countLike'],
      countComment: json['countComment'],
      date: json['date'],
    );
  }
}
