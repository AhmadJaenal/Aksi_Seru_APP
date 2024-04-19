import 'package:aksi_seru_app/screens/home/chat/list_message.dart';
import 'package:aksi_seru_app/screens/home/profile/list_article.dart';
import 'package:aksi_seru_app/screens/home/profile/list_post.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Message extends StatelessWidget {
  Message({super.key});
  TabBar tabBar = TabBar(
    padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
    labelStyle: AppTextStyle.paragraphM.copyWith(color: AppColors.primary1),
    unselectedLabelColor: AppColors.greyColor,
    indicatorColor: AppColors.primary1,
    indicatorWeight: 3,
    indicatorSize: TabBarIndicatorSize.values[1],
    splashBorderRadius: const BorderRadius.all(Radius.circular(10)),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.primary1, width: 4.0),
      insets: const EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 50.0),
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
            Image.asset('assets/icon_incoming_message.png', width: 24),
            const Gap(8),
            const Text('Kotak masuk'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_community.png', width: 24),
            const Gap(8),
            const Text('Komunitas'),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.greyColor.withOpacity(.2),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.all(AppMargin.defaultMargin),
            child: Row(
              children: [
                IconButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.primary1),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                  ),
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Gap(16),
                Text(
                  'Pesan masuk',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  surfaceTintColor: AppColors.whiteColor,
                  backgroundColor: AppColors.whiteColor,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
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
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Permintaan pesan',
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                ListMessage(),
                ListArticle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
