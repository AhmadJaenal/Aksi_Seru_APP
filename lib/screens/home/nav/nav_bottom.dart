import 'package:aksi_seru_app/screens/home/article/article_page.dart';
import 'package:aksi_seru_app/screens/home/feed/feed_page.dart';
import 'package:aksi_seru_app/screens/home/profile/verified_profile.dart';
import 'package:aksi_seru_app/screens/home/search/search_page.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';

class CustomNavBottom extends StatefulWidget {
  const CustomNavBottom({super.key});

  @override
  State<CustomNavBottom> createState() => _CustomNavBottomState();
}

class _CustomNavBottomState extends State<CustomNavBottom> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const FeedPage(),
    const SearchPage(),
    ArticlePage(),
    const FeedPage(),
    const VerifiedProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
              top: BorderSide(
                color: AppColors.greyColor.withOpacity(.2),
                width: 1,
              ),
            ),
          ),
          child: BottomAppBar(
            elevation: 0,
            padding: const EdgeInsets.all(0),
            color: AppColors.whiteColor,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icon_home.png',
                    width: 24,
                    color: AppColors.greyColor,
                  ),
                  activeIcon: Image.asset(
                    'assets/icon_home.png',
                    width: 24,
                    color: AppColors.primary1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icon_search.png',
                    width: 24,
                    color: AppColors.greyColor,
                  ),
                  activeIcon: Image.asset(
                    'assets/icon_search.png',
                    width: 24,
                    color: AppColors.primary1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icon_article.png',
                    width: 24,
                    color: AppColors.greyColor,
                  ),
                  activeIcon: Image.asset(
                    'assets/icon_article.png',
                    width: 24,
                    color: AppColors.primary1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icon_shop.png',
                    width: 24,
                    color: AppColors.greyColor,
                  ),
                  activeIcon: Image.asset(
                    'assets/icon_shop.png',
                    width: 24,
                    color: AppColors.primary1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icon_user.png',
                    width: 24,
                    color: AppColors.greyColor,
                  ),
                  activeIcon: Image.asset(
                    'assets/icon_user.png',
                    width: 24,
                    color: AppColors.primary1,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
