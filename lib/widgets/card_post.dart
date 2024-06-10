import '../getX/post.dart';
import '../shared/style.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';
import 'user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CardPost extends StatelessWidget {
  final String caption, urlImage, updatedAt;
  final List<dynamic> comment, like;

  CardPost({
    super.key,
    required this.caption,
    required this.urlImage,
    required this.updatedAt,
    required this.comment,
    required this.like,
  });

  final TextEditingController _commentPostC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _commentPostC.dispose();
  }

  LikeUnlikePost likeUnlikePost = LikeUnlikePost();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    CommentState commentState = Get.put(CommentState());

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppMargin.defaultMargin, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/user_profile.png', width: 48),
              const Gap(8),
              RichText(
                text: TextSpan(
                  style: AppTextStyle.paragraphL.copyWith(
                    color: AppColors.blackColor,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Mavropanos\n',
                    ),
                    TextSpan(
                      text: 'Artikel kreator',
                      style: AppTextStyle.paragraphM.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(4),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Verified(),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: height * .65,
                        child: Column(
                          children: [
                            const Gap(16),
                            Container(
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.greyColor,
                              ),
                            ),
                            const Gap(24),
                            Text(
                              'Postingan',
                              style: AppTextStyle.paragraphL.copyWith(
                                color: AppColors.blackColor,
                              ),
                            ),
                            const Gap(24),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(AppMargin.defaultMargin),
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: AppColors.greyColor.withOpacity(.2),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: width * .7,
                                    child: MiniButton(
                                      icon: 'icon_block.png',
                                      title: 'Edit Postingan',
                                      ontap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => EditPost(
                                        //       caption: postModel.caption,
                                        //       image: imagePost,
                                        //       idPost: postModel.idPost,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .7,
                                    child: MiniButton(
                                      icon: 'icon_block.png',
                                      title: 'Hapus Postingan',
                                      ontap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                                'Yakin hapus postingan ini?'),
                                            alignment: Alignment.center,
                                            actions: [
                                              MiniButton(
                                                  icon: 'icon_block.png',
                                                  title: 'Kembali',
                                                  ontap: () {
                                                    Get.back();
                                                  }),
                                              DangerMiniButton(
                                                icon: 'icon_block.png',
                                                title: 'Hapus',
                                                ontap: () {
                                                  // PostController.deletePost(
                                                  //   idPost: postModel.idPost,
                                                  //   context: context,
                                                  // );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Image.asset('assets/icon_option.png', width: 24),
              )
            ],
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: Text(
              caption,
              style: AppTextStyle.paragraphL.copyWith(
                color: AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onDoubleTap: () {},
              child: Image.network(urlImage),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Obx(
                () => likeUnlikePost.isLiked()
                    ? Image.asset('assets/icon_like.png', width: 24)
                    : Image.asset('assets/icon_unLike.png', width: 24),
              ),
              const Gap(16),
              GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ClipRRect(
                          borderRadius: const BorderRadiusDirectional.vertical(
                            top: Radius.circular(12),
                          ),
                          child: SizedBox(
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
                                      borderRadius:
                                          BorderRadiusDirectional.vertical(
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                        ),
                                        const Gap(24),
                                        Center(
                                          child: Text(
                                            'Postingan Mavropanos',
                                            style: AppTextStyle.paragraphL
                                                .copyWith(
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
                                    padding: EdgeInsets.all(
                                      AppMargin.defaultMargin,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      border: Border.symmetric(
                                        horizontal: BorderSide(
                                          color: AppColors.greyColor
                                              .withOpacity(.2),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CardCaption(),
                                        const Gap(12),
                                        Text(
                                          caption,
                                          style:
                                              AppTextStyle.paragraphL.copyWith(
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // NOTE :: END CODE SECTION CAPTION POST,

                                // NOTE :: STAR CODE SECTION COMMENT POST
                                // comment.isNotEmpty
                                //     ? SliverList(
                                //         delegate: SliverChildBuilderDelegate(
                                //           (context, index) {
                                //             final dataComment = comment[index];
                                //             return CardComment(
                                //               comment: dataComment[]
                                //               createdAt: comment
                                //             );
                                //           },
                                //           childCount: commentModel.length,
                                //         ),
                                //       )
                                //     : const SliverToBoxAdapter(
                                //         child: Center(
                                //           child: Text('Tidak ada komentar'),
                                //         ),
                                //       )
                                // NOTE :: END CODE SECTION COMMENT POST
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset('assets/icon_comment.png', width: 24)),
              const Gap(16),
              Image.asset('assets/icon_share.png', width: 24),
            ],
          ),
          const Gap(12),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Disukai ${like.length} orang',
              style: AppTextStyle.paragraphL.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
          const Gap(16),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return ClipRRect(
                    borderRadius: const BorderRadiusDirectional.vertical(
                      top: Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: height * .5,
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
                              padding: EdgeInsets.all(
                                AppMargin.defaultMargin,
                              ),
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
                                  const CardCaption(),
                                  const Gap(12),
                                  Text(
                                    caption,
                                    style: AppTextStyle.paragraphL.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // NOTE :: END CODE SECTION CAPTION POST,

                          // NOTE :: STAR CODE SECTION COMMENT POST
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
                          //       )
                          // NOTE :: END CODE SECTION COMMENT POST
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                Image.asset('assets/user_profile.png', width: 32),
                const Gap(6),
                Text(
                  'Gionna Van Den Berg',
                  style: AppTextStyle.paragraphL.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                const Gap(2),
                const Verified(width: 12),
                const Gap(8),
                Expanded(
                  child: Text(
                    'Keren sekali bunggggggggggggggggggggggggggg',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textController: _commentPostC,
                    hintText: 'Tulis komentarmu di sini..',
                  ),
                ),
                const Gap(10),
                PrimaryMiniIconButton(
                  icon: Icon(Icons.send, color: AppColors.whiteColor),
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      _commentPostC.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          const Gap(16),
          Text(
            '4 jam yang lalu',
            style: AppTextStyle.paragraphL.copyWith(
              color: AppColors.greyColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class CardCaption extends StatelessWidget {
  const CardCaption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/user_profile.png', width: 48),
        const Gap(8),
        RichText(
          text: TextSpan(
            style: AppTextStyle.paragraphL.copyWith(
              color: AppColors.blackColor,
            ),
            children: <TextSpan>[
              const TextSpan(
                text: 'Mavropanos\n',
              ),
              TextSpan(
                text: 'Artikel kreator',
                style: AppTextStyle.paragraphM.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
        const Gap(4),
        const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Verified(),
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            '4 jam yang lalu',
            style: AppTextStyle.paragraphL.copyWith(
              color: AppColors.greyColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class CardComment extends StatelessWidget {
  final String comment;
  final String createdAt;
  const CardComment(
      {super.key, required this.comment, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/user_profile.png', width: 48),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Gionna Van Den Berg',
                    style: AppTextStyle.paragraphL.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: AppFontWeight.medium),
                  ),
                  const Gap(4),
                  const Verified(width: 12),
                  const Gap(10),
                  Text(
                    '3 jam',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.greyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Gap(2),
              SizedBox(
                width: width * .6,
                child: Text(
                  comment,
                  style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: AppFontWeight.reguler),
                ),
              ),
              // const Gap(8),
              // Row(
              //   children: [
              //     Text(
              //       'Suka',
              //       style: AppTextStyle.paragraphL
              //           .copyWith(color: AppColors.greyColor),
              //     ),
              //     const Gap(16),
              //     Text(
              //       'Balas',
              //       style: AppTextStyle.paragraphL
              //           .copyWith(color: AppColors.greyColor),
              //     )
              //   ],
              // ),
              // const Gap(8),
              // Text(
              //   'Lihat 1 balasan',
              //   style: AppTextStyle.paragraphL
              //       .copyWith(color: AppColors.blackColor),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
