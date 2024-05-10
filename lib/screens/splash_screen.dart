import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('nama');
    developer.log(token!, name: 'get user token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary1,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 61),
                child: Image.asset('assets/pattern_top.png', width: 267),
              )),
          Padding(
            padding: EdgeInsets.only(top: 300, left: AppMargin.defaultMargin),
            child: SizedBox(
              width: 230,
              child: Text(
                'Aktivitas Komunitas Edukasi Transaksi',
                style: AppTextStyle.titlePrimary.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 130),
              child: Image.asset(
                'assets/arrow.png',
                width: 234,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Image.asset(
                'assets/pattern_bottom.png',
                width: 234,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          maximumSize: const Size(148, 62),
        ),
        onPressed: () {
          // getToken();
          Get.toNamed('/login');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mulai',
              style: AppTextStyle.h3.copyWith(color: AppColors.primary1),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.primary1,
              size: 24,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
