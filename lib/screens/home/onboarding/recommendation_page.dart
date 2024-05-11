import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(390),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppMargin.defaultMargin),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor.withOpacity(.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Rekomendasi',
                      style: AppTextStyle.appbarTitle.copyWith(
                        color: AppColors.primary1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAndToNamed('/nav-bar'),
                      child: Text(
                        'Nanti aja',
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.primary1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(16),
              Padding(
                padding: EdgeInsets.only(left: AppMargin.defaultMargin),
                child: Text(
                  'Saran pengguna',
                  style: AppTextStyle.h3.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
              const Gap(16),
              Container(
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
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
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            UserModel userData = snapshot.data![index];
                            return Padding(
                              padding: index == 0
                                  ? EdgeInsets.only(
                                      left: AppMargin.defaultMargin)
                                  : index == 9
                                      ? EdgeInsets.only(
                                          left: 8,
                                          right: AppMargin.defaultMargin)
                                      : const EdgeInsets.only(left: 8),
                              child: UserProfile(
                                userData: userData,
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text('Tidak ada data');
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const Gap(8),
              Padding(
                padding: EdgeInsets.only(left: AppMargin.defaultMargin),
                child: Text(
                  'Rekomendasi Artikel',
                  style: AppTextStyle.h3.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
              const Gap(8),
            ],
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const CardArticle();
          },
        ),
      ),
    );
  }
}
