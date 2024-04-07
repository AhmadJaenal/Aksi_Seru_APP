import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                    Text(
                      'Nanti aja',
                      style: AppTextStyle.paragraphL.copyWith(
                        color: AppColors.primary1,
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index == 0
                          ? EdgeInsets.only(left: AppMargin.defaultMargin)
                          : index == 9
                              ? EdgeInsets.only(right: AppMargin.defaultMargin)
                              : const EdgeInsets.only(left: 8),
                      child: const UserProfile(),
                    );
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
