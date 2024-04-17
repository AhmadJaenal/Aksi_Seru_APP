import 'dart:convert';

import 'package:aksi_seru_app/utils/api.dart';
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
        Get.toNamed('/login');
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                title: Text('Berhasil'),
                contentPadding: EdgeInsets.all(20),
              );
            });
        developer.log('berhasil login');
      } else if (response.statusCode == 400) {
        Map<String, dynamic> errors = jsonDecode(response.body);
        developer.log('test : ${errors['errors']['email']}', level: 0);
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Error'),
                contentPadding: const EdgeInsets.all(20),
                children: [Text(errors['errors'].toString())],
              );
            });
        Get.offAllNamed('/register');
      } else {
        developer.log(response.statusCode.toString());
      }
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error catch'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
