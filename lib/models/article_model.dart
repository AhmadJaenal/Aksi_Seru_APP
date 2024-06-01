class ArticleModel {
  final int id;
  final int userId;
  final String title;
  final String subtitle;
  final String content;
  final int countlike;
  final int countComment;
  final String urlImage;
  final String updatedAt;

  ArticleModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.countlike,
    required this.countComment,
    required this.urlImage,
    required this.updatedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['subtitle'],
      subtitle: json['title'],
      content: json['content'],
      countlike: json['countlike'],
      countComment: json['countcomment'],
      urlImage: json['urlimage'],
      updatedAt: json['updated_at'],
    );
  }

  static List<ArticleModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
  }
}
