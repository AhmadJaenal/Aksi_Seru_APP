import 'dart:convert';

import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class PostController extends GetxController {
  Future<void> createPost({String? caption, base64Image}) async {
    String? token = await UserData.getToken();

    var headers = {
      'X-Authorization': '$token',
    };
    final uri = Uri.parse(ApiEndPoints.baseUrl + Post.createPost);

    var body = jsonEncode({'image': base64Image, 'caption': caption});

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        Get.offAllNamed('/nav-bar');
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil mengunggah postingan',
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      } else {
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
    } catch (e) {
      developer.log(e.toString(), name: 'catch post');
    }
  }

  static Future<void> getPostByUser() async {
    String? token = await UserData.getToken();

    var headers = {
      'X-Authorization': '$token',
    };
    final uri = Uri.parse(ApiEndPoints.baseUrl + Post.getPostByUser);

    try {
      final response = await http.get(uri, headers: headers);

      developer.log(response.statusCode.toString(), name: 'status code');
      if (response.statusCode == 200) {
        developer.log(response.body, name: 'get post by user');
      } else {
        developer.log(response.body, name: 'get post by user');
      }
    } catch (e) {
      developer.log(e.toString(), name: 'catch post');
    }
  }
}
