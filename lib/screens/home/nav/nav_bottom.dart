import 'package:aksi_seru_app/getX/nav_bottom_state.dart';
import 'package:aksi_seru_app/screens/home/article/article_page.dart';
import 'package:aksi_seru_app/screens/home/feed/feed_page.dart';
import 'package:aksi_seru_app/screens/home/profile/verified_profile.dart';
import 'package:aksi_seru_app/screens/home/search/search_page.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavBottom extends StatelessWidget {
  const CustomNavBottom({super.key});

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(
      () => Container(
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
            currentIndex: landingPageController.tabIndex.value,
            onTap: landingPageController.changeTabIndex,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            buildBottomNavigationMenu(context, landingPageController),
        body: Obx(
          () => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              FeedPage(),
              const SearchPage(),
              ArticlePage(),
              FeedPage(),
              VerifiedProfile(),
            ],
          ),
        ),
      ),
    );
  }
}

//  Container(
//           width: double.infinity,
//           height: 80,
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             border: Border(
//               top: BorderSide(
//                 color: AppColors.greyColor.withOpacity(.2),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: 
          
//           BottomAppBar(
//             elevation: 0,
//             padding: const EdgeInsets.all(0),
//             color: AppColors.whiteColor,
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               currentIndex: _selectedIndex,
//               onTap: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Image.asset(
//                     'assets/icon_home.png',
//                     width: 24,
//                     color: AppColors.greyColor,
//                   ),
//                   activeIcon: Image.asset(
//                     'assets/icon_home.png',
//                     width: 24,
//                     color: AppColors.primary1,
//                   ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Image.asset(
//                     'assets/icon_search.png',
//                     width: 24,
//                     color: AppColors.greyColor,
//                   ),
//                   activeIcon: Image.asset(
//                     'assets/icon_search.png',
//                     width: 24,
//                     color: AppColors.primary1,
//                   ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Image.asset(
//                     'assets/icon_article.png',
//                     width: 24,
//                     color: AppColors.greyColor,
//                   ),
//                   activeIcon: Image.asset(
//                     'assets/icon_article.png',
//                     width: 24,
//                     color: AppColors.primary1,
//                   ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Image.asset(
//                     'assets/icon_shop.png',
//                     width: 24,
//                     color: AppColors.greyColor,
//                   ),
//                   activeIcon: Image.asset(
//                     'assets/icon_shop.png',
//                     width: 24,
//                     color: AppColors.primary1,
//                   ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Image.asset(
//                     'assets/icon_user.png',
//                     width: 24,
//                     color: AppColors.greyColor,
//                   ),
//                   activeIcon: Image.asset(
//                     'assets/icon_user.png',
//                     width: 24,
//                     color: AppColors.primary1,
//                   ),
//                   label: '',
//                 ),
//               ],
//             ),
//           ),
//         ),