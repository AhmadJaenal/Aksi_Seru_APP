import 'package:aksi_seru_app/controller/auth_controller.dart';
import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/screens/home/profile/list_article.dart';
import 'package:aksi_seru_app/screens/home/profile/list_post.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key});

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  LogoutController logoutController = LogoutController();

  String email = Get.arguments;

  static String myId = '';
  Future<void> getEmailId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    developer.log(email!, name: "sdfsdfsdf");

    setState(() {
      myId = email;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmailId();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = TabBar(
      controller: _tabController,
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: StreamBuilder(
          stream: UserData.getCurrentUser(emailUser: email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserModel user = snapshot.data!;

              bool isFollowing =
                  user.followers.any((user) => user['user_id'] == myId);

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
                        pinned: true,
                        collapsedHeight: 120,
                        expandedHeight: 120,
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
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(350),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.all(AppMargin.defaultMargin),
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
                                        child: user.avatar != ''
                                            ? Image.network(
                                                user.avatar,
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                              )
                                            : Image.asset(
                                                'assets/default_profile.png',
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                              ),
                                      ),
                                    ),
                                    const Gap(16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user.username,
                                          style:
                                              AppTextStyle.paragraphL.copyWith(
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
                                          onTap: () => Get.toNamed(
                                              '/list-followers',
                                              arguments: user.followers),
                                          child: Column(
                                            children: [
                                              Text(
                                                user.followers.length
                                                    .toString(),
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
                                          onTap: () => Get.toNamed(
                                              '/list-following',
                                              arguments: user.following),
                                          child: Column(
                                            children: [
                                              Text(
                                                user.following.length
                                                    .toString(),
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
                                        Expanded(
                                            child: FollowButton(
                                          email: email,
                                          isFollow: isFollowing,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color:
                                          AppColors.greyColor.withOpacity(.2),
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
                    controller: _tabController,
                    children: [
                      ListPost(email: user.email),
                      ListArticle(email: user.email),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
