import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/screens/home/profile/list_article.dart';
import 'package:aksi_seru_app/screens/home/profile/list_post.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key});

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

bool showRecommendUser = true;

class _PublicProfileState extends State<PublicProfile> {
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
            Image.asset('assets/icon_article.png', width: 24),
            const Gap(8),
            const Text('Artikel'),
          ],
        ),
      ),
    ],
  );

  final UserData user = UserData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: Gap(12),
                ),
                SliverAppBar(
                  leadingWidth: 90,
                  leading: Padding(
                    padding:
                        EdgeInsets.fromLTRB(AppMargin.defaultMargin, 5, 16, 5),
                    child: const BackButtonCustom(),
                  ),
                  title: Text(
                    'Jose',
                    style: AppTextStyle.appbarTitle.copyWith(
                      color: AppColors.primary1,
                    ),
                    maxLines: 1,
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
                    preferredSize: const Size.fromHeight(400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(AppMargin.defaultMargin),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Image.asset('assets/user_profile.png',
                                    width: 80),
                              ),
                              const Gap(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Jose',
                                    style: AppTextStyle.paragraphL.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  const Gap(4),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
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
                              const Gap(12),
                              Text(
                                'Aqua Galon',
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '0',
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
                                        '0',
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
                                        '0',
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
                                        '0',
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
                              Gap(AppMargin.defaultMargin),
                              Row(
                                children: [
                                  MiniButton(
                                    icon: 'icon_check.png',
                                    title: 'Diikuti',
                                    ontap: () => Get.toNamed('/edit-profile'),
                                    color: AppColors.primary1,
                                    iconColor: AppColors.primary1,
                                    titleColor: AppColors.primary1,
                                  ),
                                  const Spacer(),
                                  MiniButton(
                                    icon: 'icon_message.png',
                                    title: 'Kirim pesan',
                                    ontap: () {},
                                    color: AppColors.primary1,
                                    iconColor: AppColors.primary1,
                                    titleColor: AppColors.primary1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                ListPost(),
                const ListArticle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
