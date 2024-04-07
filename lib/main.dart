import 'package:aksi_seru_app/screens/auth/login.dart';
import 'package:aksi_seru_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: [
        GetPage(
          name: '/splash-screen',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => const Login(),
        ),
      ],
    );
  }
}
