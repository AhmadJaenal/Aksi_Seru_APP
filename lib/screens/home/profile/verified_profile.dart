import 'package:aksi_seru_app/controller/auth.dart';
import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/getX/counter_follow_user.dart';
import 'package:aksi_seru_app/getX/show_recommend_user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/screens/auth/login.dart';
import 'package:aksi_seru_app/screens/home/profile/list_article.dart';
import 'package:aksi_seru_app/screens/home/profile/list_following.dart';
import 'package:aksi_seru_app/screens/home/profile/list_post.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

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
            Image.asset('assets/icon_article.png', width: 24),
            const Gap(8),
            const Text('Saran pengguna'),
          ],
        ),
      ),
    ],
  );

  final ShowRecommendUserState showRecommendUser =
      Get.put(ShowRecommendUserState());
  final ListFollowersCounter listFollowers = ListFollowersCounter();

  final UserData userData = UserData();
  LogoutController logoutController = LogoutController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: FutureBuilder(
        future: userData.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            UserModel user = snapshot.data!;
            List<String> userAvatar = user.avatar.split('localhost');
            String avatar =
                "${userAvatar[0]}${ApiEndPoints.ip}${userAvatar[1]}";

            counterFollowUser.setCountUserFollow(user.following);
            counterFollowUser.setCountUserFollowers(user.followers);

            developer.log(avatar.toString());
            return DefaultTabController(
              length: 2,
              initialIndex: 1,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    const SliverToBoxAdapter(
                      child: Gap(12),
                    ),
                    SliverAppBar(
                      leading: Container(),
                      leadingWidth: 10,
                      title: Text(
                        user.name,
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
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: height * .65,
                                  child: Column(
                                    children: [
                                      const Gap(16),
                                      Container(
                                        width: 60,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                      const Gap(24),
                                      Text(
                                        'Keluar',
                                        style: AppTextStyle.paragraphL.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      const Gap(24),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(
                                            AppMargin.defaultMargin),
                                        decoration: BoxDecoration(
                                          border: Border.symmetric(
                                            horizontal: BorderSide(
                                              color: AppColors.greyColor
                                                  .withOpacity(.2),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: DangerMiniButton(
                                          icon: 'icon_block.png',
                                          title: 'Keluar dari akun anda?',
                                          ontap: () {
                                            logoutController
                                                .deleteDataUserLogin();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon:
                              Image.asset('assets/icon_option.png', width: 24),
                        ),
                        const Gap(12),
                      ],
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(
                            showRecommendUser.showRecommend() ? 680 : 440),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppMargin.defaultMargin),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.greyColor
                                              .withOpacity(.4),
                                        )),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: Image.network(
                                        avatar,
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        user.username,
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
                                    user.bio,
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
                                            user.countPost.toString(),
                                            style: AppTextStyle.h3.copyWith(
                                              fontWeight:
                                                  AppFontWeight.semiBold,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          const Gap(8),
                                          Text(
                                            'Postingan',
                                            style: AppTextStyle.paragraphL
                                                .copyWith(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            user.countArticle.toString(),
                                            style: AppTextStyle.h3.copyWith(
                                              fontWeight:
                                                  AppFontWeight.semiBold,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          const Gap(8),
                                          Text(
                                            'Artikel',
                                            style: AppTextStyle.paragraphL
                                                .copyWith(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            Get.toNamed('/list-followers'),
                                        child: Column(
                                          children: [
                                            Obx(
                                              () => Text(
                                                counterFollowUser
                                                    .counterUserFollowers
                                                    .toString(),
                                                style: AppTextStyle.h3.copyWith(
                                                  fontWeight:
                                                      AppFontWeight.semiBold,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              'Pengikut',
                                              style: AppTextStyle.paragraphL
                                                  .copyWith(
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            Get.toNamed('/list-following'),
                                        child: Column(
                                          children: [
                                            Obx(
                                              () => Text(
                                                counterFollowUser
                                                    .counterUserFollowing
                                                    .toString(),
                                                style: AppTextStyle.h3.copyWith(
                                                  fontWeight:
                                                      AppFontWeight.semiBold,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              'Diikuti',
                                              style: AppTextStyle.paragraphL
                                                  .copyWith(
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(AppMargin.defaultMargin),
                                  Row(
                                    children: [
                                      MiniButton(
                                        icon: 'icon_update_profile.png',
                                        title: 'Atur profil',
                                        ontap: () => Get.toNamed(
                                            '/edit-profile',
                                            arguments: {'user': user}),
                                        color: AppColors.primary1,
                                        iconColor: AppColors.primary1,
                                        titleColor: AppColors.primary1,
                                      ),
                                      const Spacer(),
                                      MiniButton(
                                        icon: 'icon_arrow_up.png',
                                        title: 'Saran pengguna',
                                        ontap: () {
                                          showRecommendUser.show();
                                        },
                                        color: AppColors.primary1,
                                        iconColor: AppColors.primary1,
                                        titleColor: AppColors.primary1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => showRecommendUser.showRecommend()
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppMargin.defaultMargin,
                                            vertical: 16),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: AppColors.greyColor
                                                  .withOpacity(.2),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Saran pengguna',
                                          style: AppTextStyle.h3.copyWith(
                                            color: AppColors.blackColor,
                                            fontWeight: AppFontWeight.semiBold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                            Obx(
                              () => showRecommendUser.showRecommend()
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 180,
                                      child: FutureBuilder(
                                        future: UserData.getRandomUser(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  UserModel userData =
                                                      snapshot.data![index];
                                                  return UserProfile(
                                                    userData: userData,
                                                  );
                                                },
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          } else {
                                            return const Center(
                                              child: Text("Tunggu"),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  : Container(),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
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
            );
          }
        },
      ),
    );
  }
}
