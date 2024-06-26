import 'dart:io';

import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class UserData extends GetxController {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  static Stream<UserModel?> getCurrentUser({String emailUser = ""}) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    if (email == null) {
      yield null;
      return;
    }

    yield* FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: emailUser != "" ? emailUser : email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      var userData = snapshot.docs.first.data();
      return UserModel.fromJson(userData);
    }).handleError((e) {
      developer.log(e.toString(), name: 'catch error');
      return null;
    }).asBroadcastStream();
  }

  static Stream<List<UserModel>?> getRandomUser() async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("users")
          .limit(10)
          .snapshots()
          .map((users) => UserModel.fromJsonList(users));
    } catch (e) {
      developer.log(e.toString());
    }
  }

  static updateProfile({String? name, bio, File? image}) async {
    Map<String, dynamic> updatedData = {
      "full_name": name,
      "bio": bio,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    try {
      if (image != null) {
        String imageUrl = await PostController.uploadImage(image);
        updatedData["avatar"] = imageUrl;

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          if (querySnapshot.docs.isNotEmpty) {
            for (QueryDocumentSnapshot doc in querySnapshot.docs) {
              await doc.reference.update(updatedData);
            }

            customPopUp(
              icon: Icons.check_circle_outline_rounded,
              message: 'Berhasil update profile',
              onTap: () {
                Get.back();
                Get.back();
              },
              titleButton: 'Kembali',
            );
          } else {
            customPopUp(
              icon: Icons.cancel_outlined,
              message: 'Gagal update profile',
              isSuccess: false,
              onTap: () {
                Get.back();
                Get.back();
              },
              titleButton: 'Kembali',
            );
          }
        }
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserByEmail(
      {String? email}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("email", isEqualTo: email)
        .limit(1)
        .get();
    return querySnapshot;
  }

  static followUser({String? userFollowed}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    final Map<String, dynamic> dataUserFollow = {
      "user_id": userFollowed,
    };

    final Map<String, dynamic> dataFollowers = {
      "user_id": email,
    };

    QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await UserData.getUserByEmail(email: email);

    QuerySnapshot<Map<String, dynamic>> queryUserFollowedSnapshot =
        await UserData.getUserByEmail(email: userFollowed);

    if (userSnapshot.docs.isNotEmpty) {
      String userdocId = userSnapshot.docs.first.id;
      String followdocId = queryUserFollowedSnapshot.docs.first.id;

      final FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference userRef = db.collection("users").doc(userdocId);
      DocumentReference userFollowRef = db.collection("users").doc(followdocId);

      userRef.update({
        'following': FieldValue.arrayUnion([dataUserFollow])
      });

      userFollowRef.update({
        'followers': FieldValue.arrayUnion([dataFollowers])
      });
    }
  }

  static unfollowUser({String? userFollowed}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    final Map<String, dynamic> dataUserFollow = {
      "user_id": userFollowed,
    };

    final Map<String, dynamic> dataFollowers = {
      "user_id": email,
    };

    QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await UserData.getUserByEmail(email: email);

    QuerySnapshot<Map<String, dynamic>> queryUserFollowedSnapshot =
        await UserData.getUserByEmail(email: userFollowed);

    if (userSnapshot.docs.isNotEmpty) {
      String userdocId = userSnapshot.docs.first.id;
      String followdocId = queryUserFollowedSnapshot.docs.first.id;

      final FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference userRef = db.collection("users").doc(userdocId);
      DocumentReference userFollowRef = db.collection("users").doc(followdocId);

      userRef.update({
        'following': FieldValue.arrayRemove([dataUserFollow])
      });

      userFollowRef.update({
        'followers': FieldValue.arrayRemove([dataFollowers])
      });
    }
  }
}
