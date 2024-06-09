import 'dart:convert';

import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> loginWithEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      )
          .then((userCredential) {
        final user = userCredential.user;
        user!.getIdToken().then((idToken) {
          prefs.setString('token', idToken!);
          prefs.setString('email', emailController.text);
        });
      });

      Get.offAllNamed("/recommendation-page");
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      } else if (e.code == 'network-request-failed') {
        message = 'There was a network error. Please try again.';
      } else {
        // Handle other potential errors
        print('Login error: ${e.code}');
      }
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
