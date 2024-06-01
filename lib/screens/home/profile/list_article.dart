import 'package:aksi_seru_app/controller/article_controller.dart';
import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

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
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .7,
              child: FutureBuilder<List<dynamic>?>(
                future: ArticleController.getArticle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          ArticleModel dataArticle = snapshot.data![index][0];

                          return CardArticle(article: dataArticle);
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Belum ada article yang anda buat',
                          style: AppTextStyle.h2.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      );
                    }
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
