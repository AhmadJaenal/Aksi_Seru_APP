import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class SearchState extends GetxController {
  static RxList<ArticleModel> listArticle = <ArticleModel>[].obs;
  static RxList<UserModel> listUsers = <UserModel>[].obs;

  Future<void> searchArticles({required String keyword}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> titleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('title', isLessThanOrEqualTo: keyword)
              .get();

      QuerySnapshot<Map<String, dynamic>> subtitleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('subtitle', isLessThanOrEqualTo: keyword)
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

  Future<void> searchUser({String? keyword}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> usernameSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isLessThanOrEqualTo: keyword)
              .get();

      QuerySnapshot<Map<String, dynamic>> fullNameSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('full_name', isLessThanOrEqualTo: keyword)
              .get();

      List<UserModel> users = [
        ...UserModel.fromJsonList(usernameSnapshot),
        ...UserModel.fromJsonList(fullNameSnapshot),
      ];

      List<UserModel> test = UserModel.fromJsonList(usernameSnapshot);

      listUsers.assignAll(users.toSet().toList());
      developer.log(test.toString(), name: 'result search');
    } catch (e) {
      developer.log(e.toString(), name: 'error get articles by keyword');
    }
  }
}
