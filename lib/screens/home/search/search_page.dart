import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pencarian',
                      style: AppTextStyle.appbarTitle.copyWith(
                        color: AppColors.primary1,
                      ),
                    ),
                    Gap(AppMargin.defaultMargin),
                    const CustomTextFieldIcon(
                      hintText: 'Cari inspirasi di sini!',
                      icon: Icon(
                        Icons.search,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppMargin.defaultMargin,
                top: 16,
                bottom: 16,
              ),
              child: Text(
                'Mungkin kamu kenal',
                style: AppTextStyle.h3.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppMargin.defaultMargin),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? EdgeInsets.only(left: AppMargin.defaultMargin)
                        : index == 9
                            ? EdgeInsets.only(
                                left: 8, right: AppMargin.defaultMargin)
                            : const EdgeInsets.only(left: 8),
                    child: const UserProfile(),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppMargin.defaultMargin,
                top: 16,
                bottom: 16,
              ),
              child: Text(
                'Rekomendasi Artikel',
                style: AppTextStyle.h3.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => const CardArticle(),
            ),
          ),
        ],
      ),
    );
  }
}
