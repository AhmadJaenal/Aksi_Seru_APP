import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(378),
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
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding:
                  EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
              width: double.infinity,
              child: Row(
                children: [
                  Image.asset('assets/article.png', height: width * .4),
                  const Gap(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/user_profile.png', width: 24),
                          const Gap(4),
                          Text(
                            'Alexander K..',
                            style: AppTextStyle.paragraphL.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                          const Gap(7),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary1,
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppColors.whiteColor,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Container(
                        width: 160,
                        height: 62,
                        child: Text(
                          'Edukasi Konservasi Alam dan Lingkungan Hidup',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.paragraphL.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Text(
                        '6 mnt baca Okt 23, 2023',
                        style: AppTextStyle.paragraphM.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Container(
                            height: 26,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.greyColor.withOpacity(.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Edukasi',
                              style: AppTextStyle.paragraphL.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                          const Gap(50),
                          Image.asset('assets/icon_boormark.png', width: 24),
                          Image.asset('assets/icon_option.png', width: 24),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
