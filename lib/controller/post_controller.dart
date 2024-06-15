import 'dart:developer' as developer;
import 'dart:io';

import 'package:aksi_seru_app/controller/date_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../getX/nav_bottom_state.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../widgets/custom_popup.dart';
import 'user_controller.dart';

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

      DateController date = DateController();
      final Map<String, dynamic> articleField = {
        "email": email,
        "caption": caption,
        "comment": [],
        "idlike": [],
        "updated_at": date.getDateNow(),
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

            customPopUp(
              icon: Icons.check_circle_outline_rounded,
              message: 'Berhasil mengunggah artikel',
              onTap: () {
                Get.offAllNamed('/nav-bar');
                landingPageController.changeTabIndex(4);
              },
              titleButton: 'Kembali',
            );
          } else {
            developer.log('No user found with the given email');
          }
        } catch (e) {
          customPopUp(
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
      customPopUp(
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

  static Stream<List<PostModel>> getPostByUser() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("email");
    try {
      yield* FirebaseFirestore.instance
          .collection("postUsers")
          .where("email", isEqualTo: "jenal@gmail.com")
          .snapshots()
          .map((snapshot) => PostModel.fromJsonList(snapshot));
    } catch (e) {
      developer.log(e.toString(), name: 'error get post by user');
    }
  }

  static Future<void> commentPost({
    required String postId,
    required String comment,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString("email");

      DateController date = DateController();

      Map<String, dynamic> dataComment = {
        "email": email,
        "postId": postId,
        "comment": comment,
        "created_at": date.getDateNow(),
      };

      DocumentReference<Map<String, dynamic>> response = await FirebaseFirestore
          .instance
          .collection("commentPost")
          .add(dataComment);

      if (response.id != "") {
        Map<String, dynamic> idComment = {
          "id_comment": response.id,
        };
        final FirebaseFirestore db = FirebaseFirestore.instance;
        DocumentReference postRef = db.collection("postUsers").doc(postId);
        postRef.update({
          'comment': FieldValue.arrayUnion([idComment])
        });
      }
      developer.log(response.id);
    } catch (e) {
      developer.log('Failed to comment');
    }
  }

  static Stream getCommentPost(String docId) async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("commentPost")
          .doc(docId)
          .snapshots()
          .map(
        (snapshot) {
          return DetailCommentPost.fromJson(snapshot.data()!);
        },
      );
    } catch (e) {
      developer.log('Failed to comment');
    }
  }

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
        developer.log('No user found with the given email');
      }

      customPopUp(
        icon: Icons.check_circle_outline_rounded,
        message: 'Berhasil menghapus artikel',
        onTap: () {
          Get.back();
        },
        titleButton: 'Kembali',
      );
    } catch (e) {
      customPopUp(
        icon: Icons.cancel_outlined,
        message: 'Gagal menghapus artikel',
        isSuccess: false,
        onTap: () => Get.back(),
        titleButton: 'Kembali',
      );
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

      customPopUp(
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
      customPopUp(
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

  // static Future<void> likePost({int? id}) async {
  //   String? token = await UserData.getToken();

  //   var headers = {
  //     'X-Authorization': '$token',
  //   };
  //   var body = jsonEncode({'id': id});
  //   final uri = Uri.parse(ApiEndPoints.baseUrl + Post.likePost);

  //   try {
  //     final response = await http.post(uri, headers: headers, body: body);

  //     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //     developer.log(jsonResponse.toString(), name: 'success like');
  //     if (response.statusCode == 200) {
  //       developer.log(jsonResponse['data'].toString(), name: 'success like');
  //     } else {
  //       developer.log(jsonResponse['errors'].toString(), name: 'failed like');
  //     }
  //   } catch (e) {
  //     developer.log(e.toString(), name: 'catch like');
  //   }
  // }

  // static Future<void> unLikePost({int? id}) async {
  //   String? token = await UserData.getToken();

  //   var headers = {
  //     'X-Authorization': '$token',
  //   };
  //   var body = jsonEncode({'idlike': id});
  //   developer.log(body.toString(), name: 'idlike');
  //   final uri = Uri.parse(ApiEndPoints.baseUrl + Post.unlikePost);

  //   try {
  //     final response = await http.delete(uri, headers: headers, body: body);

  //     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       developer.log(jsonResponse.toString(), name: 'success unlike');
  //     } else {
  //       developer.log(jsonResponse.toString(), name: 'failed unlike');
  //     }
  //   } catch (e) {
  //     developer.log(e.toString(), name: 'catch post');
  //   }
  // }
}
