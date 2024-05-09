import 'dart:convert';

import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class UserProvider extends ChangeNotifier {
  bool isLoading = true;
  String error = '';
  static List<UserModel> listFollowing = [];

  Future<void> userFollowing() async {
    String? token = await UserData.getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.listFollowing);

    var headers = {
      'X-Authorization': '$token',
      'Content-Type': 'application/json'
    };

    final response = await http.get(uri, headers: headers);

    try {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];

        listFollowing.clear();
        jsonResponse.forEach((data) {
          UserModel user = UserModel.fromJson(data);
          listFollowing.add(user);
        });
        notifyListeners();
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
    isLoading = false;
    notifyListeners();
  }
}
