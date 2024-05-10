import 'package:aksi_seru_app/screens/auth/create_password.dart';
import 'package:aksi_seru_app/screens/auth/create_username.dart';
import 'package:aksi_seru_app/screens/auth/login.dart';
import 'package:aksi_seru_app/screens/auth/register.dart';
import 'package:aksi_seru_app/screens/auth/success_register.dart';
import 'package:aksi_seru_app/screens/home/article/article_page.dart';
import 'package:aksi_seru_app/screens/home/article/create_article.dart';
import 'package:aksi_seru_app/screens/home/article/detail_article.dart';
import 'package:aksi_seru_app/screens/home/article/following_page.dart';
import 'package:aksi_seru_app/screens/home/article/for_you_page.dart';
import 'package:aksi_seru_app/screens/home/article/trending_page.dart';
import 'package:aksi_seru_app/screens/home/chat/list_message.dart';
import 'package:aksi_seru_app/screens/home/chat/room_message.dart';
import 'package:aksi_seru_app/screens/home/errors/check_connection.dart';
import 'package:aksi_seru_app/screens/home/feed/create_post.dart';
import 'package:aksi_seru_app/screens/home/feed/feed_page.dart';
import 'package:aksi_seru_app/screens/home/feed/review_post.dart';
import 'package:aksi_seru_app/screens/home/feed/story.dart';
import 'package:aksi_seru_app/screens/home/notification/notif_page.dart';
import 'package:aksi_seru_app/screens/home/onboarding/recommendation_page.dart';
import 'package:aksi_seru_app/screens/home/profile/edit_profile.dart';
import 'package:aksi_seru_app/screens/home/profile/list_followers.dart';
import 'package:aksi_seru_app/screens/home/profile/list_following.dart';
import 'package:aksi_seru_app/screens/home/profile/public_profile.dart';
import 'package:aksi_seru_app/screens/home/profile/verified_profile.dart';
import 'package:aksi_seru_app/screens/home/search/search_page.dart';

import 'package:aksi_seru_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import 'screens/home/nav/nav_bottom.dart';

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

  static String email = '';
  Future<String> getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      email = obtainEmail!;
      developer.log(obtainEmail, name: 'obtainemail');
    });
    return email;
  }

  @override
  void initState() {
    getValidationData();
    super.initState();
  }

  final _router = GoRouter(
    initialLocation: _MyAppState.email == '' ? '/' : '/feed-page',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const CheckConnection(page: SplashScreen()),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => CheckConnection(page: Login()),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => CheckConnection(page: Register()),
        routes: <RouteBase>[
          GoRoute(
            path: '/create-username',
            builder: (context, state) =>
                CheckConnection(page: CreateUsername()),
          ),
          GoRoute(
            path: '/create-password',
            builder: (context, state) =>
                CheckConnection(page: CreatePassword()),
          ),
          GoRoute(
            path: '/success-register',
            builder: (context, state) =>
                const CheckConnection(page: SuccessRegister()),
          ),
        ],
      ),
      GoRoute(
        path: '/recommendation-page',
        builder: (context, state) =>
            const CheckConnection(page: RecommendationPage()),
      ),
      GoRoute(
        path: '/feed-page',
        builder: (context, state) => CheckConnection(page: FeedPage()),
      ),
      GoRoute(
        path: '/create-post',
        builder: (context, state) => CheckConnection(page: CreatePost()),
      ),
      GoRoute(
        path: '/story-view',
        builder: (context, state) => const CheckConnection(page: StoryView()),
      ),
      GoRoute(
        path: '/review-post',
        builder: (context, state) => const CheckConnection(page: ReviewPost()),
      ),
      GoRoute(
        path: '/notification-page',
        builder: (context, state) =>
            const CheckConnection(page: NotificationPage()),
      ),
      GoRoute(
        path: '/nav-bar',
        builder: (context, state) =>
            const CheckConnection(page: CustomNavBottom()),
      ),
      GoRoute(
        path: '/search-page',
        builder: (context, state) => const CheckConnection(page: SearchPage()),
      ),
      GoRoute(
        path: '/article-page',
        builder: (context, state) => CheckConnection(page: ArticlePage()),
        routes: <RouteBase>[
          GoRoute(
            path: '/create-article',
            builder: (context, state) =>
                const CheckConnection(page: CreateArticle()),
          ),
          GoRoute(
            path: '/detail-article',
            builder: (context, state) =>
                const CheckConnection(page: DetailArticle()),
          ),
          GoRoute(
            path: '/trending-article',
            builder: (context, state) =>
                const CheckConnection(page: TrendingPage()),
          ),
          GoRoute(
            path: '/for-you-article',
            builder: (context, state) =>
                const CheckConnection(page: ForYouPage()),
          ),
          GoRoute(
            path: '/following-article',
            builder: (context, state) =>
                const CheckConnection(page: FollowingPage()),
          ),
        ],
      ),
      GoRoute(
        path: '/user-profile',
        builder: (context, state) =>
            const CheckConnection(page: VerifiedProfile()),
        routes: <RouteBase>[
          GoRoute(
            path: '/edit-profile',
            builder: (context, state) =>
                const CheckConnection(page: EditProfile()),
          ),
          GoRoute(
            path: '/list-following',
            builder: (context, state) =>
                const CheckConnection(page: ListFollowing()),
          ),
          GoRoute(
            path: '/list-followers',
            builder: (context, state) =>
                const CheckConnection(page: ListFollowers()),
          ),
        ],
      ),
      GoRoute(
        path: '/public-profile',
        builder: (context, state) =>
            const CheckConnection(page: PublicProfile()),
      ),
      GoRoute(
        path: '/message',
        builder: (context, state) => const CheckConnection(page: ListMessage()),
        routes: <RouteBase>[
          GoRoute(
            path: '/room-message',
            builder: (context, state) =>
                const CheckConnection(page: RoomMessage()),
          ),
        ],
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

      // home: email != '' ? const CustomNavBottom() : const SplashScreen(),

// getPages: [
//         GetPage(
//           name: '/splash-screen',
//           page: () => const SplashScreen(),
//         ),
//         GetPage(
//           name: '/login',
//           page: () => CheckConnection(page: Login()),
//         ),
//         GetPage(
//           name: '/register',
//           page: () => CheckConnection(page: Register()),
//         ),
//         GetPage(
//           name: '/verified-code',
//           page: () => CheckConnection(page: VerifiedCode()),
//         ),
//         GetPage(
//           name: '/create-password',
//           page: () => CheckConnection(page: CreatePassword()),
//         ),
//         GetPage(
//           name: '/success-register',
//           page: () => const CheckConnection(page: SuccessRegister()),
//         ),
//         GetPage(
//           name: '/create-username',
//           page: () => CheckConnection(page: CreateUsername()),
//         ),
//         GetPage(
//           name: '/recommendation-page',
//           page: () => const CheckConnection(page: RecommendationPage()),
//         ),
//         GetPage(
//           name: '/feed-page',
//           page: () => CheckConnection(page: FeedPage()),
//         ),
//         GetPage(
//           name: '/create-post',
//           page: () => CheckConnection(page: CreatePost()),
//         ),
//         GetPage(
//           name: '/story',
//           page: () => const CheckConnection(page: StoryView()),
//         ),
//         GetPage(
//           name: '/review-post',
//           page: () => const CheckConnection(page: ReviewPost()),
//         ),
//         GetPage(
//           name: '/notification-page',
//           page: () => const CheckConnection(page: NotificationPage()),
//         ),
//         GetPage(
//           name: '/nav-bar',
//           page: () => const CheckConnection(page: CustomNavBottom()),
//         ),
//         GetPage(
//           name: '/search-page',
//           page: () => const CheckConnection(page: SearchPage()),
//         ),
//         GetPage(
//           name: '/article-page',
//           page: () => CheckConnection(page: ArticlePage()),
//         ),
//         GetPage(
//           name: '/detail-article',
//           page: () => const CheckConnection(page: DetailArticle()),
//         ),
//         GetPage(
//           name: '/trending-article',
//           page: () => const CheckConnection(page: TrendingPage()),
//         ),
//         GetPage(
//           name: '/for-you-article',
//           page: () => const CheckConnection(page: ForYouPage()),
//         ),
//         GetPage(
//           name: '/following-article',
//           page: () => const CheckConnection(page: FollowingPage()),
//         ),
//         GetPage(
//           name: '/create-article',
//           page: () => const CheckConnection(page: CreateArticle()),
//         ),
//         GetPage(
//           name: '/verified-profile',
//           page: () => const CheckConnection(page: VerifiedProfile()),
//         ),
//         GetPage(
//           name: '/public-profile',
//           page: () => const CheckConnection(page: PublicProfile()),
//         ),
//         GetPage(
//           name: '/message',
//           page: () => CheckConnection(page: Message()),
//         ),
//         GetPage(
//           name: '/list-message',
//           page: () => const CheckConnection(page: ListMessage()),
//         ),
//         GetPage(
//           name: '/room-message',
//           page: () => const CheckConnection(page: RoomMessage()),
//         ),
//         GetPage(
//           name: '/edit-profile',
//           page: () => const CheckConnection(page: EditProfile()),
//         ),
//         GetPage(
//           name: '/list-following',
//           page: () => const CheckConnection(page: ListFollowing()),
//         ),
//         GetPage(
//           name: '/list-followers',
//           page: () => const CheckConnection(page: ListFollowers()),
//         ),
//       ],