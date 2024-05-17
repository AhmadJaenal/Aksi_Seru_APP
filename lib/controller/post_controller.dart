import 'dart:convert';

import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/post_model.dart';
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

  static Future<List?> getPostByUser() async {
    String? token = await UserData.getToken();

    var headers = {
      'X-Authorization': '$token',
    };
    final uri = Uri.parse(ApiEndPoints.baseUrl + Post.getPostByUser);

    try {
      final response = await http.get(uri, headers: headers);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        List listPostAndLike = [];
        jsonResponse.forEach((key, value) {
          listPostAndLike.add([
            PostModel.fromJson(value['post'][0]),
            LikeModel.fromJsonList(value['like']),
            CommentModel.fromJsonList(value['comment']),
          ]);
        });

        return listPostAndLike;
      } else {
        developer.log(response.body, name: 'failed get post by user');
        return null;
      }
    } catch (e) {
      developer.log(e.toString(), name: 'catch post test');
      return null;
    }
  }

  static Future<void> commentPost({int? id, String? comment}) async {
    String? token = await UserData.getToken();

    var headers = {
      'X-Authorization': '$token',
    };
    final uri = Uri.parse(ApiEndPoints.baseUrl + Post.commentPost);

    var body = jsonEncode({
      "id": id,
      "comment": comment,
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        developer.log(jsonResponse.toString(), name: 'success comment in post');
      } else {
        developer.log(jsonResponse.toString(), name: 'failed comment in post');
      }
    } catch (e) {
      developer.log(e.toString(), name: 'catch post test');
    }
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
