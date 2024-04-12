class ArticleModel {
  final int idArticle;
  final String idUser;
  final List<String> tag;
  final int countComment;
  final String date;

  ArticleModel({
    required this.idArticle,
    required this.idUser,
    required this.tag,
    required this.countComment,
    required this.date,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      idArticle: json['idArticle'],
      idUser: json['idUser'],
      tag: json['tag'],
      countComment: json['countComment'],
      date: json['date'],
    );
  }
}
