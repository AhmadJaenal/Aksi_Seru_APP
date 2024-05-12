import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/getX/show_recommend_user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    showRecommendUser.showRecommend = true.obs;

    _searchC.dispose();
    super.dispose();
  }

  final ShowRecommendUserState showRecommendUser =
      Get.put(ShowRecommendUserState());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: Container(
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
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pencarian',
                        style: AppTextStyle.appbarTitle.copyWith(
                            color: AppColors.primary1, letterSpacing: -2),
                      ),
                      Gap(AppMargin.defaultMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * .7,
                            child: CustomTextFieldIcon(
                              textController: _searchC,
                              hintText: 'Cari pengguna!',
                              icon: const Icon(
                                Icons.search,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: IconButton(
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
                              onPressed: () {
                                setState(() {
                                  UserData.searchUser(
                                    username: _searchC.text,
                                  );
                                });
                              },
                              icon: Image.asset(
                                'assets/icon_search.png',
                                width: 24,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => showRecommendUser.showRecommend()
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: AppMargin.defaultMargin,
                        top: 16,
                        bottom: 16,
                        right: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mungkin kamu kenal',
                            style: AppTextStyle.h3.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showRecommendUser.show(),
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => showRecommendUser.showRecommend()
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          vertical: AppMargin.defaultMargin),
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.greyColor.withOpacity(.2),
                            width: 1,
                          ),
                        ),
                      ),
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
                                  UserModel userData = snapshot.data![index];
                                  return UserProfile(userData: userData);
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(
                                "Tunggu",
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  : Container(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
              child: StreamBuilder(
                stream: UserData.searchUser(username: _searchC.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .65,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          UserModel userData = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: OtherUserProfileWidget(
                              userData: userData,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Pengguna tidak ditemukan',
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
