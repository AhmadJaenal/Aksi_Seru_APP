import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const CardArticle(),
              childCount: 5,
            ),
          ),
          SliverToBoxAdapter(
            child: Gap(AppMargin.defaultMargin),
          ),
        ],
      ),
    );
  }
}
