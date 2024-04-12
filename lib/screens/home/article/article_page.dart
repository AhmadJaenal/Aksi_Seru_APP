import 'package:aksi_seru_app/screens/home/article/following_page.dart';
import 'package:aksi_seru_app/screens/home/article/for_you_page.dart';
import 'package:aksi_seru_app/screens/home/article/trending_page.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({super.key});

  TabBar tabBar = TabBar(
    labelStyle: AppTextStyle.paragraphM.copyWith(color: AppColors.primary1),
    unselectedLabelColor: AppColors.greyColor,
    indicatorColor: AppColors.primary1,
    indicatorWeight: 3,
    isScrollable: true,
    unselectedLabelStyle:
        AppTextStyle.paragraphM.copyWith(color: AppColors.greyColor),
    tabs: [
      Tab(
        child: Row(
          children: [
            Image.asset('assets/icon_for_you.png', width: 24),
            const Gap(8),
            const Text('Untuk kamu'),
          ],
        ),
      ),
      Tab(
        child: Row(
          children: [
            Image.asset('assets/icon_follow.png', width: 24),
            const Gap(8),
            const Text('Mengikuti'),
          ],
        ),
      ),
      Tab(
        child: Row(
          children: [
            Image.asset('assets/icon_trend.png', width: 24),
            const Gap(8),
            const Text('Trending'),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(340),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(AppMargin.defaultMargin),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.greyColor.withOpacity(.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Artikel',
                        style: AppTextStyle.appbarTitle.copyWith(
                            color: AppColors.primary1, letterSpacing: -2),
                      ),
                      Gap(AppMargin.defaultMargin),
                      const CustomTextFieldIcon(
                        hintText: 'Cari inspirasi di sini!',
                        icon: Icon(
                          Icons.search,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(AppMargin.defaultMargin),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.greyColor.withOpacity(.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      MiniButton(
                        icon: 'icon_update_profile.png',
                        title: 'Atur profil',
                        ontap: () {},
                        color: AppColors.primary1,
                        iconColor: AppColors.primary1,
                        titleColor: AppColors.primary1,
                      ),
                      const Spacer(),
                      MiniButton(
                        icon: 'icon_pen.png',
                        title: 'Tulis artikel',
                        ontap: () => Get.toNamed('/create-article'),
                        color: AppColors.primary1,
                        iconColor: AppColors.primary1,
                        titleColor: AppColors.primary1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                width: double.infinity,
                height: 70,
                padding:
                    EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                ),
                child: tabBar,
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ForYouPage(),
            FollowingPage(),
            TrendingPage(),
          ],
        ),
      ),
    );
  }
}
