import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/getX/nav_bottom_state.dart';
import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/models/post_model.dart';
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

class PostController extends GetxController {
  static Future<void> createpostFirebase(
      {required caption, required File image}) async {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    final storageRef = FirebaseStorage.instance.ref();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    try {
      final imageRef = storageRef
          .child('postImage/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await imageRef.putFile(image);

      final imageUrl = await imageRef.getDownloadURL();

      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference ref = db.collection("postUsers");
      final Map<String, dynamic> articleField = {
        "email": email,
        "caption": caption,
        "comment": [],
        "idlike": [],
        "updated_at": "",
        "urlimage": imageUrl,
      };
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
              "count_post": userModel.countPost + 1,
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
  }

  static Stream getPostByUser() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    try {
      yield* FirebaseFirestore.instance
          .collection("postUsers")
          .where("email", isEqualTo: email)
          .snapshots();
      ;
    } catch (e) {
      developer.log(e.toString(), name: 'error get post by user');
    }
  }

  static Future<void> commentPost(
      {required String postId, required String comment, File? image}) async {}

  static Future<void> deletePost({String? docId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    try {
      await FirebaseFirestore.instance
          .collection("postUsers")
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
          "count_post": userModel.countArticle - 1,
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
          message: 'Berhasil hapus postingan',
          onTap: () {},
          titleButton: 'Halaman Profile',
        );
        Get.offAllNamed('/nav-bar');
        landingPageController.changeTabIndex(4);
      } else {
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Terjadi kesalahan hapus postingan!',
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
        // developer.log(response.body, name: 'Failed to comment on post');
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch comment post error');
    }
  }

  static Future<void> updatePost({
    File? image,
    String? caption,
    required String docId,
  }) async {
    DateTime now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);

    Map<String, dynamic> updatedData = {
      "caption": caption,
      "updated_at": date,
    };

    try {
      if (image != null) {
        String imageUrl = await _uploadImage(image);
        updatedData["urlimage"] = imageUrl;
      }

      developer.log(updatedData.toString(), name: 'test updated data');

      await FirebaseFirestore.instance
          .collection("postUsers")
          .doc(docId)
          .update(updatedData);

        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
        message: 'Berhasil update postingan',
          onTap: () {
          Get.back();
          Get.back();
          Get.back();
          },
          titleButton: 'Kembali',
        );
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
  }

  static Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef
        .child('postImage/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await imageRef.putFile(image);
    String urlImage = await imageRef.getDownloadURL();
    return urlImage;
  }

  static Future<void> likePost({int? id}) async {
    String? token = await UserData.getToken();

    var headers = {
      'X-Authorization': '$token',
    };
    var body = jsonEncode({'id': id});
    final uri = Uri.parse(ApiEndPoints.baseUrl + Post.likePost);

    try {
      final response = await http.post(uri, headers: headers, body: body);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      developer.log(jsonResponse.toString(), name: 'success like');
      if (response.statusCode == 200) {
        developer.log(jsonResponse['data'].toString(), name: 'success like');
      } else {
        developer.log(jsonResponse['errors'].toString(), name: 'failed like');
      }
    } catch (e) {
      developer.log(e.toString(), name: 'catch like');
    }
  }

  static Future<void> unLikePost({int? id}) async {
    String? token = await UserData.getToken();

    var headers = {
      'X-Authorization': '$token',
    };
    var body = jsonEncode({'idlike': id});
    developer.log(body.toString(), name: 'idlike');
    final uri = Uri.parse(ApiEndPoints.baseUrl + Post.unlikePost);

    try {
      final response = await http.delete(uri, headers: headers, body: body);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        developer.log(jsonResponse.toString(), name: 'success unlike');
      } else {
        developer.log(jsonResponse.toString(), name: 'failed unlike');
      }
    } catch (e) {
      developer.log(e.toString(), name: 'catch post');
    }
  }
}
