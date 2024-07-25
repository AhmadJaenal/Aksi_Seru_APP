import '../widgets/custom_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        "avatar": "",
        "bio": "",
        "followers": [],
        "following": [],
      };

      await ref.add(userData).then((docRef) {
        customPopUp(
          icon: Icons.check_circle_outline_rounded,
          message: 'Berhasil membuat akun',
          onTap: () {
            Get.toNamed('/login');
          },
          titleButton: 'Lanjut Login',
        );
      });
      emailController.clear();
      usernameController.clear();
      nameController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        developer.log('The password provided is too weak.');
        customPopUp(
          icon: Icons.cancel_outlined,
          isSuccess: false,
          message: 'Password terlalu lemah',
          onTap: () {
            Get.back();
            Get.back();
          },
          titleButton: 'Kembali',
        );
      } else if (e.code == 'email-already-in-use') {
        developer.log('The account already exists for that email.');
        customPopUp(
          icon: Icons.cancel_outlined,
          isSuccess: false,
          message: 'Email sudah terdaftar',
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      }
    } catch (e) {
      developer.log(e.toString());
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
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        customPopUp(
          icon: Icons.cancel_outlined,
          isSuccess: false,
          message: 'User tidak ditemukan',
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      } else if (e.code == 'wrong-password' || e.code == 'invalid-email') {
        customPopUp(
          icon: Icons.cancel_outlined,
          isSuccess: false,
          message: 'Email atau password salah',
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      } else {
        customPopUp(
          icon: Icons.cancel_outlined,
          isSuccess: false,
          message: 'Terjadi kesalahan',
          onTap: () {
            Get.back();
          },
          titleButton: 'Kembali',
        );
      }
      developer.log(e.code);
    }
  }
}

class LogoutController extends GetxController {
  Future<void> deleteDataUserLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      Get.offAllNamed('/login');
      sharedPreferences.setString('token', '');
    } catch (e) {
      developer.log(e.toString(), name: 'error logout');
    }
  }
}
