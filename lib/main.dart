import 'package:aksi_seru_app/screens/auth/create_password.dart';
import 'package:aksi_seru_app/screens/auth/create_username.dart';
import 'package:aksi_seru_app/screens/auth/login.dart';
import 'package:aksi_seru_app/screens/auth/register.dart';
import 'package:aksi_seru_app/screens/auth/success_register.dart';
import 'package:aksi_seru_app/screens/auth/verified_code_register.dart';
import 'package:aksi_seru_app/screens/home/article/article_page.dart';
import 'package:aksi_seru_app/screens/home/article/create_article.dart';
import 'package:aksi_seru_app/screens/home/article/detail_article.dart';
import 'package:aksi_seru_app/screens/home/article/following_page.dart';
import 'package:aksi_seru_app/screens/home/article/for_you_page.dart';
import 'package:aksi_seru_app/screens/home/article/trending_page.dart';
import 'package:aksi_seru_app/screens/home/chat/list_chat.dart';
import 'package:aksi_seru_app/screens/home/feed/create_post.dart';
import 'package:aksi_seru_app/screens/home/feed/feed_page.dart';
import 'package:aksi_seru_app/screens/home/feed/review_post.dart';
import 'package:aksi_seru_app/screens/home/feed/story.dart';
import 'package:aksi_seru_app/screens/home/nav/nav_bottom.dart';
import 'package:aksi_seru_app/screens/home/notification/notif_page.dart';
import 'package:aksi_seru_app/screens/home/onboarding/recommendation_page.dart';
import 'package:aksi_seru_app/screens/home/profile/verified_profile.dart';
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
      home: SplashScreen(),
      getPages: [
        GetPage(
          name: '/splash-screen',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => Login(),
        ),
        GetPage(
          name: '/register',
          page: () => Register(),
        ),
        GetPage(
          name: '/verified-code',
          page: () => VerifiedCode(),
        ),
        GetPage(
          name: '/create-password',
          page: () => CreatePassword(),
        ),
        GetPage(
          name: '/success-register',
          page: () => const SuccessRegister(),
        ),
        GetPage(
          name: '/create-username',
          page: () => CreateUsername(),
        ),
        GetPage(
          name: '/recommendation-page',
          page: () => const RecommendationPage(),
        ),
        GetPage(
          name: '/feed-page',
          page: () => FeedPage(),
        ),
        GetPage(
          name: '/create-post',
          page: () => CreatePost(),
        ),
        GetPage(
          name: '/story',
          page: () => StoryView(),
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
          page: () => SearchPage(),
        ),
        GetPage(
          name: '/article-page',
          page: () => ArticlePage(),
        ),
        GetPage(
          name: '/detail-article',
          page: () => const DetailArticle(),
        ),
        GetPage(
          name: '/trending-article',
          page: () => const TrendingPage(),
        ),
        GetPage(
          name: '/for-you-article',
          page: () => const ForYouPage(),
        ),
        GetPage(
          name: '/following-article',
          page: () => const FollowingPage(),
        ),
        GetPage(
          name: '/create-article',
          page: () => const CreateArticle(),
        ),
        GetPage(
          name: '/verified-profile',
          page: () => const VerifiedProfile(),
        ),
        GetPage(
          name: '/message',
          page: () => Message(),
        ),
      ],
    );
  }
}
