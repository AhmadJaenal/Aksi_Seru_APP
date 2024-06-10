import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/getX/nav_bottom_state.dart';
import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class ArticleController extends GetxController {
  static Stream<List<ArticleModel>?> getArticleByUser(
      {required int idUser}) async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("articles")
          .where("idUser", isEqualTo: idUser)
          .snapshots()
          .map((snapshot) => ArticleModel.fromJsonList(snapshot));
    } catch (e) {
      developer.log(e.toString(), name: 'error get article by user');
    }
  }

  static Stream<ArticleModel?> getDetailArticle(
      {required String docId}) async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("articles")
          .doc(docId)
          .snapshots()
          .map((snapshot) => ArticleModel.fromJson(snapshot.data()!, docId));
    } catch (e) {
      developer.log(e.toString(), name: 'error get article by user');
    }
  }

  static Future<List<ArticleModel>> getRecommendArticle() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("articles").get();

    List<ArticleModel> articles = ArticleModel.fromJsonList(querySnapshot);

    return articles;
  }

  static void createArticleFirebase(
      {required int id,
      required String title,
      subtitle,
      content,
      required File image}) async {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef
        .child('articlImage/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await imageRef.putFile(image);

    final imageUrl = await imageRef.getDownloadURL();

    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference ref = db.collection("articles");
    final Map<String, dynamic> articleField = {
      "idUser": id,
      "title": title,
      "subtitle": subtitle,
      "content": content,
      "urlimage": imageUrl,
      "comment": [],
      "countcomment": 0,
      "idlike": [],
      "countlike": 0,
      "updated_at": ""
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    await ref.add(articleField).then((docRef) async {
      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await UserData.getUserByEmail(email: email);

        if (querySnapshot.docs.isNotEmpty) {
          QueryDocumentSnapshot<Map<String, dynamic>> userDoc =
              querySnapshot.docs.first;
          Map<String, dynamic> userData = userDoc.data();

          UserModel userModel = UserModel.fromJson(userData);

          Map<String, dynamic> updatedData = {
            "count_article": userModel.countArticle + 1,
          };

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userDoc.id)
              .update(updatedData);

          CustomPopUp(
            icon: Icons.check_circle_outline_rounded,
            message: 'Berhasil mengunggah artikel',
            onTap: () {
              Get.offAllNamed('/nav-bar');
              landingPageController.changeTabIndex(4);
            },
            titleButton: 'Kembali',
          );
        } else {
          print('No user found with the given email');
        }
      } catch (e) {
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Terjadi saat mengunggah',
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      }
    });
  }

  static void deleteArticle({required String docId}) async {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    try {
      await FirebaseFirestore.instance
          .collection("articles")
          .doc(docId)
          .delete();

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .where("email", isEqualTo: email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot<Map<String, dynamic>> userDoc =
            querySnapshot.docs.first;
        Map<String, dynamic> userData = userDoc.data();

        UserModel userModel = UserModel.fromJson(userData);

        Map<String, dynamic> updatedData = {
          "count_article": userModel.countArticle - 1,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDoc.id)
            .update(updatedData);
      } else {
        print('No user found with the given email');
      }

      CustomPopUp(
        icon: Icons.check_circle_outline_rounded,
        message: 'Berhasil menghapus artikel',
        onTap: () {
          Get.offAllNamed('/nav-bar');
          landingPageController.changeTabIndex(4);
        },
        titleButton: 'Kembali',
      );
    } catch (error) {
      CustomPopUp(
        icon: Icons.cancel_outlined,
        message: 'Gagal menghapus artikel',
        isSuccess: false,
        onTap: () => Get.back(),
        titleButton: 'Kembali',
      );
    }
  }

  static Future<void> commentArticle(
      {required String docId, required CommentModel comment}) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    developer.log(comment.toJson().toString());

    DocumentReference postRef = db.collection('articles').doc(docId);
    postRef.update({
      'comment': FieldValue.arrayUnion([comment.toJson()])
    });
  }

  static void editArticle(
      {int? id, String? title, subtitle, content, category, image64}) async {
    String? token = await UserData.getToken();

    final uri = Uri.parse(ApiEndPoints.baseUrl + Article.updateArticle);

    var headers = {'X-Authorization': '$token'};
    var body = jsonEncode({
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'category': category,
      'image': image64,
    });

    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil edit artikel',
          onTap: () {
            Get.offAllNamed('/nav-bar');
            landingPageController.changeTabIndex(4);
          },
          titleButton: 'Kembali',
        );
      } else {
        developer.log(response.statusCode.toString(),
            name: 'update edit article');
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Gagal menghapus artikel',
          isSuccess: false,
          onTap: () => Get.back(),
          titleButton: 'Kembali',
        );
      }
    } catch (e) {
      developer.log(e.toString(), name: 'catch get article');
    }
  }

  // static Future<List<dynamic>?> getRecommendArticle(
  //     {int? id, String? title, subtitle, content, category, image64}) async {
  //   String? token = await UserData.getToken();

  //   final uri =
  //       Uri.parse("http://192.168.177.106/api/api/article/recommendation.php");

  //   var headers = {'X-Authorization': '$token'};

  //   final LandingPageController landingPageController =
  //       Get.put(LandingPageController(), permanent: false);

  //   try {
  //     final response = await http.get(uri, headers: headers);
  //     if (response.statusCode == 200) {
  //       developer.log(response.statusCode.toString(),
  //           name: 'test response get random article');
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
  //       List listArticleAndLike = [];

  //       jsonResponse.forEach((key, value) {
  //         listArticleAndLike.add([
  //           ArticleModel.fromJson(value['article'][0]),
  //         ]);
  //       });

  //       return listArticleAndLike;
  //     } else {
  //       developer.log(response.body.toString(), name: 'response get article');
  //     }
  //   } catch (e) {
  //     developer.log(e.toString(), name: 'catch get article');
  //   }
  // }
}
