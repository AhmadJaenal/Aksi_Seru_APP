import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:dio/dio.dart' as dio;

class UserData extends GetxController {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<UserModel?> getCurrentUser() async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.currentUser);
    var headers = {
      'X-Authorization': '$token',
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
        // developer.log(jsonResponse.toString(), name: 'json response');

        UserModel user = UserModel.fromJson(jsonResponse);
        return user;
      } else if (response.statusCode == 401) {
        developer.log('Unauthorized');
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error get user');
    }
  }

  static updateUserProfile({String? name, bio, image}) async {
    String? token = await getToken();
    var headers = {
      'X-Authorization': '$token',
    };

    final uri =
        Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.updateUserProfile);

    var body = {
      'name': name,
      'bio': bio,
      'avatar': image,
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil Perbaharui Profile',
          onTap: () {
            Get.offNamed('/verified-profile');
          },
          titleButton: 'Halaman Profile',
        );
      } else if (response.statusCode == 400) {
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
        // developer.log(jsonResponse.toString(), name: 'Response');

        List<UserModel> userData = [];
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          userData.add(user);
        });

        // developer.log(userData.toString(), name: 'userData');
        return userData;
      } else if (response.statusCode == 401) {
        developer.log('Unauthorized');
        return null;
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error get user');
    }
  }

  static Future<void> followUser({String? idUser}) async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.followUser);
    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      'iduser': idUser,
    });
    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        developer.log(response.body, name: 'Response Follow User');
      } else {
        developer.log(response.body, name: 'Response Follow User');
        developer.log(response.statusCode.toString(),
            name: 'Response Follow User status code');
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

  static Future<void> unFollowUser({String? idUser}) async {
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

  static Future<void> listFollowing() async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.listFollowing);

    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        developer.log(response.body, name: 'Response List User');
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

  static Future<List<UserModel>?> listFollowers() async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.listFollowers);

    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };
    final response = await http.get(uri, headers: headers);
    try {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];

        List<UserModel> userData = [];
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          userData.add(user);
        });
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
