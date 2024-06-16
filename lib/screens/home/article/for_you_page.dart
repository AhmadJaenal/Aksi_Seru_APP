import '../../../controller/article_controller.dart';
import '../../../models/article_model.dart';
import '../../../shared/style.dart';
import '../../../widgets/card_article.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Gap(AppMargin.defaultMargin),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .5,
              child: FutureBuilder<List<dynamic>?>(
                future: ArticleController.getRecommendArticle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
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
