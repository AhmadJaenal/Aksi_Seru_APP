import 'package:aksi_seru_app/screens/auth/create_password.dart';
import 'package:aksi_seru_app/screens/auth/create_username.dart';
import 'package:aksi_seru_app/screens/auth/login.dart';
import 'package:aksi_seru_app/screens/auth/register.dart';
import 'package:aksi_seru_app/screens/auth/success_register.dart';
import 'package:aksi_seru_app/screens/auth/verified_code_register.dart';
import 'package:aksi_seru_app/screens/home/feed/create_post.dart';
import 'package:aksi_seru_app/screens/home/feed/feed_page.dart';
import 'package:aksi_seru_app/screens/home/feed/review_post.dart';
import 'package:aksi_seru_app/screens/home/feed/story.dart';
import 'package:aksi_seru_app/screens/home/nav/nav_bottom.dart';
import 'package:aksi_seru_app/screens/home/notification/notif_page.dart';
import 'package:aksi_seru_app/screens/home/onboarding/recommendation_page.dart';
import 'package:aksi_seru_app/screens/home/search/search_page.dart';
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
        GetPage(
          name: '/register',
          page: () => const Register(),
        ),
        GetPage(
          name: '/verified-code',
          page: () => const VerifiedCode(),
        ),
        GetPage(
          name: '/create-password',
          page: () => const CreatePassword(),
        ),
        GetPage(
          name: '/success-register',
          page: () => const SuccessRegister(),
        ),
        GetPage(
          name: '/create-username',
          page: () => const CreateUsername(),
        ),
        GetPage(
          name: '/recommendation-page',
          page: () => const RecommendationPage(),
        ),
        GetPage(
          name: '/feed-page',
          page: () => const FeedPage(),
        ),
        GetPage(
          name: '/create-post',
          page: () => const CreatePost(),
        ),
        GetPage(
          name: '/story',
          page: () => const StoryView(),
        ),
        GetPage(
          name: '/review-post',
          page: () => const ReviewPost(),
        ),
        GetPage(
          name: '/notification-page',
          page: () => const NotificationPage(),
        ),
        GetPage(
          name: '/nav-bar',
          page: () => const CustomNavBottom(),
        ),
        GetPage(
          name: '/search-page',
          page: () => const SearchPage(),
        ),
      ],
    );
  }
}
