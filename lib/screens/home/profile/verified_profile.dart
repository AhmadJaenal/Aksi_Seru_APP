import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifiedProfile extends StatelessWidget {
  VerifiedProfile({super.key});

  TabBar tabBar = TabBar(
    labelStyle: AppTextStyle.paragraphM.copyWith(color: AppColors.primary1),
    unselectedLabelColor: AppColors.greyColor,
    indicatorColor: AppColors.primary1,
    indicatorWeight: 3,
    isScrollable: true,
    unselectedLabelStyle:
        AppTextStyle.paragraphM.copyWith(color: AppColors.greyColor),
    tabs: [
      Tab(
        child: Row(
          children: [
            Image.asset('assets/icon_for_you.png', width: 24),
            const Gap(8),
            const Text('Untuk kamu'),
          ],
        ),
      ),
      Tab(
        child: Row(
          children: [
            Image.asset('assets/icon_follow.png', width: 24),
            const Gap(8),
            const Text('Mengikuti'),
          ],
        ),
      ),
      Tab(
        child: Row(
          children: [
            Image.asset('assets/icon_trend.png', width: 24),
            const Gap(8),
            const Text('Trending'),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(96),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.greyColor.withOpacity(.2),
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.all(AppMargin.defaultMargin),
          child: Row(
            children: [
              SizedBox(
                width: width * .6,
                child: Text(
                  'George Low',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Get.toNamed('/notification-page'),
                icon: Image.asset('assets/icon_share.png', width: 24),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icon_option.png', width: 24),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 390,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Gap(AppMargin.defaultMargin),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.asset('assets/user_profile.png', width: 80),
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
                  Text(
                    'Hidup itu sederhana, apa yang membuat kita bahagia, maka lakukanlah',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.blackColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  const Gap(16),
                  Row(
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
                            '3',
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
                            '3',
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
                            '3',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
