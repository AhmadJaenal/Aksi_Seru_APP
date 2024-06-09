import 'dart:convert';

import 'package:aksi_seru_app/getX/counter_follow_user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class UserData extends GetxController {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Stream<UserModel?> getCurrentUser() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    if (email == null) {
      yield null;
      return;
    }

    yield* FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      var userData = snapshot.docs.first.data();
      developer.log(userData.toString(), name: "user data");
      return UserModel.fromJson(userData);
    }).handleError((e) {
      developer.log(e.toString(), name: 'catch error');
      return null;
    });
  }

  static updateUserProfile({required String name, bio, image}) async {
    String? token = await getToken();
    var headers = {
      'X-Authorization': '$token',
    };

    final uri =
        Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.updateUserProfile);

    var data = jsonEncode({
      'name': name,
      'bio': bio,
      'avatar': image,
    });

    try {
      final response = await http.post(uri, headers: headers, body: data);
      if (response.statusCode == 200) {
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil Perbaharui Profile',
          onTap: () {
            Get.offNamed('/nav-bar');
          },
          titleButton: 'Halaman Profile',
        );
      } else if (response.statusCode == 400) {
        developer.log(response.body.toString(),
            name: 'response code update profile');
        CustomPopUp(
          icon: Icons.cancel_outlined,
          isSuccess: false,
          message: 'Profile Tidak Diperbaharui',
          onTap: () {
            Get.offNamed('/verified-profile');
          },
          titleButton: 'Halaman Profile',
        );
      }
      developer.log(response.body.toString(),
          name: 'response code update profile');
    } catch (e) {
      developer.log(e.toString(), name: 'error copy image');
    }
  }

  static Future<List<UserModel>?> getRandomUser() async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.randomUser);
    var headers = {
      'X-Authorization': '$token',
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];

        List<UserModel> userData = [];
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          userData.add(user);
        });

        return userData;
      } else if (response.statusCode == 401) {
        developer.log('Unauthorized');
        return null;
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error get user');
    }
  }

  // static Future<void> followUser({UserModel? userData}) async {
  //   final CounterFollowUser counterFollowUser = Get.put(CounterFollowUser());
  //   final ListFollowingCounter listFollowingCounter =
  //       Get.put(ListFollowingCounter());

  //   String? token = await getToken();
  //   final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.followUser);
  //   var headers = {
  //     'X-Authorization': '$token',
  //     'Content-Type': 'application/json'
  //   };
  //   var body = jsonEncode({
  //     'iduser': userData!.id,
  //   });
  //   try {
  //     final response = await http.post(uri, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       counterFollowUser.follow();
  //       listFollowingCounter.follow(userData);
  //     } else {
  //       CustomPopUp(
  //         icon: Icons.cancel_outlined,
  //         message: 'Terjadi kesalahan diserver',
  //         isSuccess: false,
  //         onTap: () {
  //           Get.back();
  //         },
  //         titleButton: 'Kembali',
  //       );
  //     }
  //   } catch (e) {
  //     developer.log('Error: $e', name: 'error follow user');
  //   }
  // }

  static Future<void> unFollowUser({String? idUser}) async {
    final ListFollowingCounter listFollowingCounter =
        Get.put(ListFollowingCounter());
    final CounterFollowUser counterFollowUser = Get.put(CounterFollowUser());

    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.unFollowUser);
    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      'iduser': idUser,
    });
    try {
      final response = await http.delete(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        counterFollowUser.unfollow();
        listFollowingCounter.unFollow(int.parse(idUser!));
      } else {
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Terjadi kesalahan diserver',
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error follow user');
    }
  }

  static Future<void> deleteFollowers({String? idUser}) async {
    final ListFollowersCounter listFollowersCounter =
        Get.put(ListFollowersCounter());
    final CounterFollowUser counterFollowUser = Get.put(CounterFollowUser());

    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.deleteFollowers);
    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      'iduser': idUser,
    });
    try {
      final response = await http.delete(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        listFollowersCounter.deleteFollowers(int.parse(idUser!));
        counterFollowUser.deleteFollower();
        developer.log(response.body, name: 'Response Follow User');
      } else {
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Terjadi kesalahan diserver',
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error follow user');
    }
  }

  static Future<List<UserModel>?> listFollowing() async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.listFollowing);
    final ListFollowingCounter listFollowingCounter =
        Get.put(ListFollowingCounter());

    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];

        List<UserModel> userData = [];
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          userData.add(user);
        });
        listFollowingCounter.setUserData(userData);

        return userData;
      } else {
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Terjadi kesalahan diserver',
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
        return null;
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error follow user');
      return null;
    }
  }

  static Future<List<UserModel>?> listFollowers() async {
    String? token = await getToken();
    final ListFollowersCounter listFollowersCounter =
        Get.put(ListFollowersCounter());
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.listFollowers);

    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];

        List<UserModel> userData = [];
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          userData.add(user);
        });
        listFollowersCounter.setUserData(userData);
        return userData;
      } else {
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Terjadi kesalahan diserver',
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
        return null;
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error follow user');
      return null;
    }
  }

  static Stream<List<UserModel>> searchUser({String? username}) async* {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.searchUser);
    var headers = {
      'X-Authorization': '$token',
    };
    var body = jsonEncode({
      'search': username,
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);
      List<UserModel> userData = [];
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          userData.add(user);
        });
        yield userData;
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error follow user');
    }
  }
}
