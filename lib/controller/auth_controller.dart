import 'dart:convert';

import 'package:aksi_seru_app/controller/user_controller.dart';
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
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference ref = db.collection("users");
      final Map<String, dynamic> userData = {
        "full_name": nameController.text,
        "email": emailController.text,
        "username": usernameController.text,
        "count_post": 0,
        "count_article": 0,
      };

      await ref.add(userData).then((docRef) {
        CustomPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil membuat akun',
          onTap: () {
            Get.toNamed('/login');
          },
          titleButton: 'Lanjut Login',
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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

    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginWithEmail);
    Map<String, String> body = {
      'email': emailController.text.trim(),
      'password': passwordController.text,
    };
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: header);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
        String token = jsonResponse['token'];
        String email = jsonResponse['email'];
        developer.log(token, name: 'user token login email');
        if (token.isNotEmpty) {
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          await prefs.setString('email', email);
          emailController.clear();
          passwordController.clear();
          Get.toNamed('/recommendation-page');
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

class LogoutController extends GetxController {
  Future<void> deleteDataUserLogin() async {
    String? token = await UserData.getToken();
    final uri = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.logout,
    );

    var headers = {
      'X-Authorization': '$token',
    };

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      http.Response response = await http.delete(uri, headers: headers);
      if (response.statusCode == 200) {
        sharedPreferences.setString('email', '');
        sharedPreferences.setString('token', '');
        Get.offAndToNamed('/login');
      }
      developer.log(response.statusCode.toString(), name: 'response logout');
    } catch (e) {
      developer.log(e.toString(), name: 'error logout');
    }
  }
}