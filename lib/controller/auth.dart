import 'dart:convert';

import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class RegisterationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final Future<SharedPreferences> _presf = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    var header = {'Content-type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerWithEmail);
      Map body = {
        'username': usernameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'name': nameController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: header);

      developer.log('status code ${response.statusCode}');

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil membuat akun',
          isSuccess: false,
          onTap: () {
            Get.toNamed('/login');
          },
          titleButton: 'Lanjut Login',
        );
        developer.log('berhasil login');
      } else if (response.statusCode == 400) {
        Map<String, dynamic> errors = jsonDecode(response.body);
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: 'Gagal membuat akun\n $errors',
          isSuccess: false,
          onTap: () {
            Get.offAllNamed('/register');
          },
          titleButton: 'Daftar ulang',
        );
      } else {
        developer.log(response.statusCode.toString(), name: 'test');
      }
    } catch (e) {
      CustomPopUp(
        icon: Icons.cancel_outlined,
        message: 'Terjadi kesalahan diserver',
        isSuccess: false,
        onTap: () {
          Get.back();

          Get.offAllNamed('/register');
        },
        titleButton: 'Daftar ulang',
      );
    }
  }
}

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var header = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginWithEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: header);
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        developer.log(json, name: 'response success login');
      } else {
        developer.log(response.body, name: 'response success failed');
      }
    } catch (e) {
      developer.log('error catch');
    }
  }
}
