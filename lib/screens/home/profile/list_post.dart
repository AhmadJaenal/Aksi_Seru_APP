import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_post.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListPost extends StatelessWidget {
  const ListPost({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Gap(AppMargin.defaultMargin)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context, index) => const CardPost(),
          ))
        ],
      ),
    );
  }
}
