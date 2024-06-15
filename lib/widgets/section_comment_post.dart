import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/models/post_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_post.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class SectionComment extends StatelessWidget {
  final double height;
  final PostModel postModel;

  const SectionComment({
    super.key,
    required this.height,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .9,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            collapsedHeight: 100,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.whiteColor,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  const Gap(16),
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                  const Gap(24),
                  Center(
                    child: Text(
                      'Postingan Mavropanos',
                      style: AppTextStyle.paragraphL.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // NOTE :: START CODE SECTION CAPTION POST
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const CardCaption(),
                  const Gap(12),
                  Text(
                    postModel.caption.toString(),
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // NOTE :: END CODE SECTION CAPTION POST
          // NOTE :: START CODE SECTION COMMENT POST
          // commentModel.isNotEmpty
          //     ? SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //           (context, index) {
          //             final comment = commentModel[index];
          //             return CardComment(
          //               comment: comment.comment,
          //               createdAt: comment.createdAt,
          //             );
          //           },
          //           childCount: commentModel.length,
          //         ),
          //       )
          //     : const SliverToBoxAdapter(
          //         child: Center(
          //           child: Text('Tidak ada komentar'),
          //         ),
          //       ),
          // NOTE :: END CODE SECTION COMMENT POST
        ],
      ),
    );
  }
}
