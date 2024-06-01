import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: AppColors.whiteColor,
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverToBoxAdapter(
    //         child: Gap(AppMargin.defaultMargin),
    //       ),
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //           (context, index) => const CardArticle(),
    //           childCount: 5,
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: Gap(AppMargin.defaultMargin),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      body: Text('Ongoing'),
    );
  }
}
