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
import 'package:aksi_seru_app/screens/home/chat/list_message.dart';
import 'package:aksi_seru_app/screens/home/chat/message_page.dart';
import 'package:aksi_seru_app/screens/home/chat/room_message.dart';
import 'package:aksi_seru_app/screens/home/errors/check_connection.dart';
import 'package:aksi_seru_app/screens/home/feed/create_post.dart';
import 'package:aksi_seru_app/screens/home/feed/feed_page.dart';
import 'package:aksi_seru_app/screens/home/feed/review_post.dart';
import 'package:aksi_seru_app/screens/home/feed/story.dart';
import 'package:aksi_seru_app/screens/home/nav/nav_bottom.dart';
import 'package:aksi_seru_app/screens/home/notification/notif_page.dart';
import 'package:aksi_seru_app/screens/home/onboarding/recommendation_page.dart';
import 'package:aksi_seru_app/screens/home/profile/edit_profile.dart';
import 'package:aksi_seru_app/screens/home/profile/public_profile.dart';
import 'package:aksi_seru_app/screens/home/profile/verified_profile.dart';
import 'package:aksi_seru_app/screens/home/search/search_page.dart';
import 'package:aksi_seru_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> setToken() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('token', '');
  }

  Future<Widget> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token!.isEmpty) {
      return const CheckConnection(page: SplashScreen());
    } else {
      return const CheckConnection(page: CustomNavBottom());
    }
  }

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
          page: () => CheckConnection(page: Login()),
        ),
        GetPage(
          name: '/register',
          page: () => CheckConnection(page: Register()),
        ),
        GetPage(
          name: '/verified-code',
          page: () => CheckConnection(page: VerifiedCode()),
        ),
        GetPage(
          name: '/create-password',
          page: () => CheckConnection(page: CreatePassword()),
        ),
        GetPage(
          name: '/success-register',
          page: () => const CheckConnection(page: SuccessRegister()),
        ),
        GetPage(
          name: '/create-username',
          page: () => CheckConnection(page: CreateUsername()),
        ),
        GetPage(
          name: '/recommendation-page',
          page: () => const CheckConnection(page: RecommendationPage()),
        ),
        GetPage(
          name: '/feed-page',
          page: () => CheckConnection(page: FeedPage()),
        ),
        GetPage(
          name: '/create-post',
          page: () => CheckConnection(page: CreatePost()),
        ),
        GetPage(
          name: '/story',
          page: () => const CheckConnection(page: StoryView()),
        ),
        GetPage(
          name: '/review-post',
          page: () => const CheckConnection(page: ReviewPost()),
        ),
        GetPage(
          name: '/notification-page',
          page: () => const CheckConnection(page: NotificationPage()),
        ),
        GetPage(
          name: '/nav-bar',
          page: () => const CheckConnection(page: CustomNavBottom()),
        ),
        GetPage(
          name: '/search-page',
          page: () => CheckConnection(page: SearchPage()),
        ),
        GetPage(
          name: '/article-page',
          page: () => CheckConnection(page: ArticlePage()),
        ),
        GetPage(
          name: '/detail-article',
          page: () => const CheckConnection(page: DetailArticle()),
        ),
        GetPage(
          name: '/trending-article',
          page: () => const CheckConnection(page: TrendingPage()),
        ),
        GetPage(
          name: '/for-you-article',
          page: () => const CheckConnection(page: ForYouPage()),
        ),
        GetPage(
          name: '/following-article',
          page: () => const CheckConnection(page: FollowingPage()),
        ),
        GetPage(
          name: '/create-article',
          page: () => const CheckConnection(page: CreateArticle()),
        ),
        GetPage(
          name: '/verified-profile',
          page: () => const CheckConnection(page: VerifiedProfile()),
        ),
        GetPage(
          name: '/public-profile',
          page: () => const CheckConnection(page: PublicProfile()),
        ),
        GetPage(
          name: '/message',
          page: () => CheckConnection(page: Message()),
        ),
        GetPage(
          name: '/list-message',
          page: () => const CheckConnection(page: ListMessage()),
        ),
        GetPage(
          name: '/room-message',
          page: () => const CheckConnection(page: RoomMessage()),
        ),
        GetPage(
          name: '/edit-profile',
          page: () => const CheckConnection(page: EditProfile()),
        ),
      ],
    );
  }
}
