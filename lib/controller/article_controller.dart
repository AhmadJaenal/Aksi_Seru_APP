import 'dart:convert';

import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/getX/nav_bottom_state.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ArticleController extends GetxController {
  static Future createArticle(
      {String? title, subtitle, content, base64Image, category}) async {
    String? token = await UserData.getToken();

    final uri = Uri.parse(ApiEndPoints.baseUrl + Article.createArticle);

    var headers = {
      'X-Authorization': '$token',
    };
    var body = jsonEncode({
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'category': category,
      'image': base64Image,
    });

    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
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
}
