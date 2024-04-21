import 'dart:convert';

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

  @override
  void disposeId(Object id) {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.disposeId(id);
  }

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
        usernameController.clear();
        nameController.clear();
        passwordController.clear();
        emailController.clear();
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil membuat akun',
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

  @override
  void disposeId(Object id) {
    emailController.dispose();
    passwordController.dispose();
    super.disposeId(id);
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var header = {'Content-Type': 'application/json'};

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginWithEmail);
      Map<String, String> body = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
        String token = jsonResponse['token'];
        // developer.log(token, name: 'user token login email');
        if (token.isNotEmpty) {
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          emailController.clear();
          passwordController.clear();
          Get.offAllNamed('/recommendation-page');
        }
      } else {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)['errors'];
        String messageError = jsonResponse['message'][0];

        developer.log(messageError, name: 'response failed login');
        CustomPopUp(
          icon: Icons.cancel_outlined,
          message: messageError,
          isSuccess: false,
          onTap: () {
            Get.back();
          },
          titleButton: 'Login kembali',
        );
      }
    } catch (e) {
      CustomPopUp(
        icon: Icons.cancel_outlined,
        message: 'Terjadi kesalahan',
        isSuccess: false,
        onTap: () {
          Get.back();
        },
        titleButton: 'Login kembali',
      );
      developer.log('Error: $e', name: 'error catch');
    }
  }
}
