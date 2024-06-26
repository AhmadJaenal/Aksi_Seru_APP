import 'package:aksi_seru_app/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class SearcArticlehState extends GetxController {
  static RxList<ArticleModel> listArticle = <ArticleModel>[].obs;

  Future<void> searchArticles({required String keyword}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> titleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('title', isEqualTo: keyword)
              .get();

      QuerySnapshot<Map<String, dynamic>> subtitleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('subtitle', isEqualTo: keyword)
              .get();

      List<ArticleModel> articles = [
        ...ArticleModel.fromJsonList(titleSnapshot),
        ...ArticleModel.fromJsonList(subtitleSnapshot),
      ];

      listArticle.assignAll(articles.toSet().toList());

      developer.log(listArticle.toString(), name: 'result search');
    } catch (e) {
      developer.log(e.toString(), name: 'error get articles by keyword');
    }
  }
}
