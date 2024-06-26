import 'package:aksi_seru_app/getX/search_state.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../shared/style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import 'following_page.dart';
import 'for_you_page.dart';
import 'trending_page.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final TextEditingController _searchC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _searchC.dispose();
  }

  SearcArticlehState searcArticlehState = SearcArticlehState();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(230),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Padding(
                  padding: EdgeInsets.only(left: AppMargin.defaultMargin),
                  child: Text(
                    'Artikel',
                    style: AppTextStyle.appbarTitle.copyWith(
                      color: AppColors.primary1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(20),
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppMargin.defaultMargin),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: CustomTextField(
                              textController: _searchC,
                              hintText: 'Cari inpirasi!'),
                        ),
                        const Spacer(),
                        IconButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.primary1),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(12)),
                          ),
                          onPressed: () {
                            searcArticlehState.searchArticles(
                                keyword: _searchC.text);
                          },
                          icon: Image.asset('assets/icon_image.png', width: 24),
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                TabBar(
                  padding: EdgeInsets.zero,
                  labelStyle: AppTextStyle.paragraphM
                      .copyWith(color: AppColors.primary1),
                  unselectedLabelColor: AppColors.greyColor,
                  indicatorColor: AppColors.primary1,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.values[1],
                  splashFactory: NoSplash.splashFactory,
                  splashBorderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: AppColors.primary1, width: 4.0),
                    insets: const EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 50.0),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10)),
                  ),
                  dividerColor: Colors.transparent,
                  unselectedLabelStyle: AppTextStyle.paragraphM
                      .copyWith(color: AppColors.greyColor),
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
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: AppMargin.defaultMargin,
                      vertical: AppMargin.defaultMargin / 2),
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
              ],
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
