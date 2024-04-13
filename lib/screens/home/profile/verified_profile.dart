import 'package:aksi_seru_app/screens/home/article/following_page.dart';
import 'package:aksi_seru_app/screens/home/article/for_you_page.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifiedProfile extends StatelessWidget {
  VerifiedProfile({super.key});

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
            Image.asset('assets/icon_list_post.png', width: 24),
            const Gap(8),
            const Text('Postingan'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_arrow_up.png', width: 24),
            const Gap(8),
            const Text('Saran pengguna'),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.whiteColor,
                title: Text(
                  'George Low',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/icon_share.png', width: 24),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/icon_option.png', width: 24),
                  ),
                  const Gap(12),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(477),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child:
                            Image.asset('assets/user_profile.png', width: 80),
                      ),
                      const Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'George Low',
                            style: AppTextStyle.paragraphL.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                          const Gap(4),
                          Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary1,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Text(
                        'Pengamat',
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                      const Gap(12),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppMargin.defaultMargin),
                        child: Text(
                          'Hidup itu sederhana, apa yang membuat kita bahagia, maka lakukanlah',
                          style: AppTextStyle.paragraphL.copyWith(
                            color: AppColors.blackColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                      const Gap(16),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppMargin.defaultMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '3',
                                  style: AppTextStyle.h3.copyWith(
                                    fontWeight: AppFontWeight.semiBold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  'Postingan',
                                  style: AppTextStyle.paragraphL.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '1',
                                  style: AppTextStyle.h3.copyWith(
                                    fontWeight: AppFontWeight.semiBold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  'Artikel',
                                  style: AppTextStyle.paragraphL.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '2893',
                                  style: AppTextStyle.h3.copyWith(
                                    fontWeight: AppFontWeight.semiBold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  'Pengikut',
                                  style: AppTextStyle.paragraphL.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '147',
                                  style: AppTextStyle.h3.copyWith(
                                    fontWeight: AppFontWeight.semiBold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  'Diikuti',
                                  style: AppTextStyle.paragraphL.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(AppMargin.defaultMargin),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppMargin.defaultMargin),
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
                      const Gap(24),
                      Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: AppColors.greyColor.withOpacity(.2),
                              width: 1,
                            ),
                          ),
                        ),
                        child: tabBar,
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
                            SizedBox(
                              width: width * .7,
                              child: const CustomTextField(
                                  hintText:
                                      'Share hal seru kalian hari ini, yuk!'),
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
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.primary1),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(12)),
                              ),
                              onPressed: () => Get.toNamed('/create-post'),
                              icon: Image.asset('assets/icon_image.png',
                                  width: 24),
                            )
                          ],
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
