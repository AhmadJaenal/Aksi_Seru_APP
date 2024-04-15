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

  final TextEditingController _searchC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _searchC.dispose();
  }

  TabBar tabBar = TabBar(
    padding: EdgeInsets.zero,
    labelStyle: AppTextStyle.paragraphM.copyWith(color: AppColors.primary1),
    unselectedLabelColor: AppColors.greyColor,
    indicatorColor: AppColors.primary1,
    indicatorWeight: 3,
    indicatorSize: TabBarIndicatorSize.values[1],
    splashFactory: NoSplash.splashFactory,
    splashBorderRadius: const BorderRadius.all(Radius.circular(10)),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.primary1, width: 4.0),
      insets: const EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 50.0),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    dividerColor: Colors.transparent,
    unselectedLabelStyle:
        AppTextStyle.paragraphM.copyWith(color: AppColors.greyColor),
    tabs: [
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_for_you.png', width: 24),
            const Gap(8),
            const Text('Untuk kamu'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_follow.png', width: 24),
            const Gap(8),
            const Text('Mengikuti'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: Gap(12),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Artikel',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(250),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsetsDirectional.all(AppMargin.defaultMargin),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.greyColor.withOpacity(.2),
                              width: 1,
                            ),
                          ),
                        ),
                        child: CustomTextFieldIcon(
                          textController: _searchC,
                          hintText: 'Cari inspirasi di sini!',
                          icon: const Icon(
                            Icons.search,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsetsDirectional.all(AppMargin.defaultMargin),
                        decoration: BoxDecoration(
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
                              icon: 'icon_article.png',
                              title: 'Artikel saya',
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
                      Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.greyColor.withOpacity(.2),
                              width: 1,
                            ),
                          ),
                        ),
                        child: tabBar,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ForYouPage(),
              FollowingPage(),
              TrendingPage(),
            ],
          ),
        ),
      ),
    );
  }
}
