import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/screens/home/profile/list_article.dart';
import 'package:aksi_seru_app/screens/home/profile/list_post.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class VerifiedProfile extends StatefulWidget {
  const VerifiedProfile({super.key});

  @override
  State<VerifiedProfile> createState() => _VerifiedProfileState();
}

@override
bool showRecommendUser = true;

class _VerifiedProfileState extends State<VerifiedProfile> {
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

  final UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: FutureBuilder(
        future: userData.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            UserModel user = snapshot.data!;
            // Uint8List image = base64Decode(user.avatar);
            List<String> userAvatar = user.avatar.split('localhost');
            String avatar =
                "${userAvatar[0]}${ApiEndPoints.ip}${userAvatar[1]}";
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
                          onPressed: () {},
                          icon:
                              Image.asset('assets/icon_option.png', width: 24),
                        ),
                        const Gap(12),
                      ],
                      bottom: PreferredSize(
                        preferredSize:
                            Size.fromHeight(showRecommendUser ? 680 : 440),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppMargin.defaultMargin),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    child: Image.network(
                                      avatar,
                                      fit: BoxFit.cover,
                                      width: 70,
                                      height: 70,
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
                                            Text(
                                              user.followers.toString(),
                                              style: AppTextStyle.h3.copyWith(
                                                fontWeight:
                                                    AppFontWeight.semiBold,
                                                color: AppColors.blackColor,
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
                                            Text(
                                              user.following.toString(),
                                              style: AppTextStyle.h3.copyWith(
                                                fontWeight:
                                                    AppFontWeight.semiBold,
                                                color: AppColors.blackColor,
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
                                          setState(() {
                                            showRecommendUser =
                                                !showRecommendUser;
                                          });
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
                            Visibility(
                              visible: showRecommendUser,
                              child: Align(
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
                                        color:
                                            AppColors.greyColor.withOpacity(.2),
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
                              ),
                            ),
                            Visibility(
                              visible: showRecommendUser,
                              child: SizedBox(
                                width: double.infinity,
                                height: 180,
                                child: FutureBuilder(
                                  future: UserData.getRandomUser(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            UserModel userData =
                                                snapshot.data![index];
                                            return UserProfile(
                                              username: userData.username,
                                              avatar: userData.avatar,
                                              idUser: userData.id,
                                            );
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    } else {
                                      return const Center(
                                        child: Text("Tunggu"),
                                      );
                                    }
                                  },
                                ),
                              ),
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
