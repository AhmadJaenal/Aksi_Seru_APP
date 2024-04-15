import 'dart:async';

import 'package:aksi_seru_app/shared/style.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
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
      floatingActionButton: _connectionStatus
              .contains(ConnectivityResult.mobile)
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                maximumSize: const Size(148, 62),
              ),
              onPressed: () => Get.toNamed('/login'),
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
            )
          : SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: AppColors.whiteColor)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
