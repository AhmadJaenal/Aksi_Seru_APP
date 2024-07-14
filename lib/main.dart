import 'dart:io';

import 'firebase_options.dart';
import 'screens/auth/create_password.dart';
import 'screens/auth/create_username.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/auth/success_register.dart';
import 'screens/home/article/article_page.dart';
import 'screens/home/article/create_article.dart';
import 'screens/home/article/detail_article.dart';
import 'screens/home/article/edit_article.dart';
import 'screens/home/article/following_page.dart';
import 'screens/home/article/for_you_page.dart';
import 'screens/home/article/trending_page.dart';
import 'screens/home/errors/check_connection.dart';
import 'screens/home/feed/create_post.dart';
import 'screens/home/feed/edit_post.dart';
import 'screens/home/feed/feed_page.dart';
import 'screens/home/feed/review_post.dart';
import 'screens/home/feed/story_view.dart';
import 'screens/home/notification/notif_page.dart';
import 'screens/home/onboarding/recommendation_page.dart';
import 'screens/home/profile/edit_profile.dart';
import 'screens/home/profile/list_followers.dart';
import 'screens/home/profile/list_following.dart';
import 'screens/home/profile/public_profile.dart';
import 'screens/home/profile/verified_profile.dart';
import 'screens/home/search/search_page.dart';

import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home/feed/create_story.dart';
import 'screens/home/nav/nav_bottom.dart';

import 'package:firebase_core/firebase_core.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token!.isEmpty) {
      return const CheckConnection(page: SplashScreen());
    } else {
      return const CheckConnection(page: CustomNavBottom());
    }
  }

  static String token = '';
  Future<String> getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var tokenResult = sharedPreferences.getString('token');

    setState(() {
      token = tokenResult!;
    });
    return token;
  }

  @override
  void initState() {
    getValidationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token != ''
          ? const CheckConnection(page: CustomNavBottom())
          : const CheckConnection(page: SplashScreen()),
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
          page: () => const CheckConnection(page: CreatePost()),
        ),
        GetPage(
          name: '/create-story',
          page: () => const CheckConnection(page: CreateStory()),
        ),
        GetPage(
          name: '/story-view',
          page: () => const CheckConnection(page: StoryView()),
        ),
        GetPage(
          name: '/review-post',
          page: () => CheckConnection(page: ReviewPost()),
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
          page: () => const CheckConnection(page: SearchPage()),
        ),
        GetPage(
          name: '/article-page',
          page: () => const CheckConnection(page: ArticlePage()),
        ),
        GetPage(
          name: '/detail-article',
          page: () => CheckConnection(page: DetailArticle()),
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
          name: '/edit-profile',
          page: () => const CheckConnection(page: EditProfile()),
        ),
        GetPage(
          name: '/list-following',
          page: () => CheckConnection(page: ListFollowing()),
        ),
        GetPage(
          name: '/list-followers',
          page: () => CheckConnection(page: ListFollowers()),
        ),
        GetPage(
          name: '/edit-post',
          page: () => const CheckConnection(page: EditPost()),
        ),
        GetPage(
          name: '/edit-article',
          page: () => const CheckConnection(page: EditArticle()),
        ),
      ],
    );
  }
}
