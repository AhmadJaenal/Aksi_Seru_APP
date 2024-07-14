import 'package:aksi_seru_app/controller/article_controller.dart';
import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListArticle extends StatelessWidget {
  bool isPublicProfile;
  ListArticle({super.key, this.isPublicProfile = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              child: Visibility(
                visible: !isPublicProfile,
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .7,
              child: StreamBuilder<List<dynamic>?>(
                stream: ArticleController.getArticleByUser(idUser: 1),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ArticleModel dataArticle = snapshot.data![index];
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
