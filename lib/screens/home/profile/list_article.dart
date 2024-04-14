import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListArticle extends StatelessWidget {
  const ListArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              child: MiniButton(
                icon: 'icon_pen.png',
                ontap: () => Get.toNamed('/create-article'),
                title: 'Tulis artikel',
                color: AppColors.primary1,
                titleColor: AppColors.primary1,
                iconColor: AppColors.primary1,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context, index) => const CardArticle(),
          ))
        ],
      ),
    );
  }
}
