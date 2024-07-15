import 'package:aksi_seru_app/controller/date_controller.dart';
import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/models/post_model.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:audioplayers/audioplayers.dart';

import '../getX/post.dart';
import '../shared/style.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';
import 'user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CardPost extends StatelessWidget {
  final PostModel postData;

  CardPost({super.key, required this.postData});

  final TextEditingController _commentPostC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _commentPostC.dispose();
  }

  LikeUnlikePost likeUnlikePost = LikeUnlikePost();

  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    likeUnlikePost.initializeLikeState(postData.likes);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppMargin.defaultMargin, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: UserData.getCurrentUser(emailUser: postData.email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data!;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userData.avatar != ""
                          ? GestureDetector(
                              onTap: () => Get.toNamed('/public-profile',
                                  arguments: userData.email),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    userData.avatar,
                                    width: 36,
                                    height: 36,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : Image.asset('assets/user_profile.png', width: 48),
                      const Gap(8),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyle.paragraphL.copyWith(
                            color: AppColors.blackColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${userData.username}\n',
                            ),
                            TextSpan(
                              text: userData.bio != "" ? userData.bio : "",
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
                                      padding: EdgeInsets.all(
                                          AppMargin.defaultMargin),
                                      decoration: BoxDecoration(
                                        border: Border.symmetric(
                                          horizontal: BorderSide(
                                            color: AppColors.greyColor
                                                .withOpacity(.2),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: width * .7,
                                            child: MiniButton(
                                              icon: 'icon_edit.png',
                                              title: 'Edit Postingan',
                                              ontap: () {
                                                Get.toNamed('/edit-post',
                                                    arguments: postData);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * .7,
                                            child: DangerMiniButton(
                                              icon: 'icon_delete.png',
                                              title: 'Hapus Postingan',
                                              ontap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                        'Yakin hapus postingan ini?'),
                                                    alignment: Alignment.center,
                                                    actions: [
                                                      MiniButton(
                                                          iconColor: AppColors
                                                              .greyColor,
                                                          icon:
                                                              'icon_close.png',
                                                          title: 'Batal',
                                                          ontap: () {
                                                            Get.back();
                                                          }),
                                                      DangerMiniButton(
                                                        icon: 'icon_check.png',
                                                        title: 'Hapus',
                                                        ontap: () {
                                                          Get.back();
                                                          Get.back();
                                                          PostController
                                                              .deletePost(
                                                                  docId: postData
                                                                      .docId);
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
                  );
                } else {
                  return const SizedBox();
                }
              }),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: Text(
              postData.caption,
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
              onDoubleTap: () {
                player.play(AssetSource("audio/tombol_ditekan.mp3"));
                likeUnlikePost.setLikeUnlike(idPost: postData.docId);
              },
              child: Image.network(postData.urlImage),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    likeUnlikePost.setLikeUnlike(idPost: postData.docId);
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: likeUnlikePost.isLiked.value
                        ? Image.asset(
                            'assets/icon_like.png',
                            width: 24,
                            key: const ValueKey('icon_like'),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'assets/icon_unLike.png',
                            width: 24,
                            key: const ValueKey('icon_unLike'),
                            fit: BoxFit.contain,
                          ),
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
                                            'Postingan dfgdfg',
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
                                        CardCaption(
                                            datePost: postData.updatedAt),
                                        const Gap(12),
                                        Text(
                                          postData.caption,
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
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      CommentPostModel idComment =
                                          postData.comments[index];

                                      return StreamBuilder(
                                        stream: PostController.getCommentPost(
                                            idComment.idComment),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            DetailCommentPost detailComment =
                                                snapshot.data;
                                            return CardComment(
                                              email: detailComment.email,
                                              comment: detailComment.comment,
                                              createdAt: detailComment.createAt,
                                            );
                                          } else {
                                            return const Text(
                                                "Belum ada komentar");
                                          }
                                        },
                                      );
                                    },
                                    childCount: postData.comments.length,
                                  ),
                                )
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
              'Disukai ${postData.likes.length} orang',
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
                                  CardCaption(datePost: postData.updatedAt),
                                  const Gap(12),
                                  Text(
                                    postData.caption,
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
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                CommentPostModel idComment =
                                    postData.comments[index];

                                return StreamBuilder(
                                  stream: PostController.getCommentPost(
                                      idComment.idComment),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      DetailCommentPost detailComment =
                                          snapshot.data;
                                      return CardComment(
                                        email: detailComment.email,
                                        comment: detailComment.comment,
                                        createdAt: detailComment.createAt,
                                      );
                                    } else {
                                      return const Text("Belum ada komentar");
                                    }
                                  },
                                );
                              },
                              childCount: postData.comments.length,
                            ),
                          )
                          // NOTE :: END CODE SECTION COMMENT POST
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: postData.comments.isNotEmpty
                ? FutureBuilder(
                    future: UserData.getUserByEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.waiting) {
                        UserModel userData =
                            UserModel.fromJson(snapshot.data!.docs[0].data());
                        return Row(
                          children: [
                            userData.avatar != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(userData.avatar,
                                        width: 32, height: 32),
                                  )
                                : Image.asset('assets/user_profile.png',
                                    width: 32),
                            const Gap(6),
                            Text(
                              userData.username,
                              style: AppTextStyle.paragraphL.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: AppFontWeight.bold,
                              ),
                            ),
                            const Gap(2),
                            const Verified(width: 12),
                            const Gap(8),
                            StreamBuilder(
                              stream: PostController.getCommentPost(
                                  postData.comments[0].idComment),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  DetailCommentPost detailComment =
                                      snapshot.data;
                                  return Expanded(
                                    child: Text(
                                      detailComment.comment,
                                      style: AppTextStyle.paragraphL.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                } else {
                                  return const Text("Belum ada komentar");
                                }
                              },
                            )
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : Container(),
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
                      PostController.commentPost(
                        comment: _commentPostC.text,
                        postId: postData.docId,
                      );
                      _commentPostC.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardCaption extends StatelessWidget {
  String datePost;
  CardCaption({
    super.key,
    required this.datePost,
  });

  @override
  Widget build(BuildContext context) {
    DateController date = DateController();
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
            date.checkDifferenceTime(date: datePost),
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
  final String email;
  const CardComment(
      {super.key,
      required this.comment,
      required this.createdAt,
      required this.email});

  @override
  Widget build(BuildContext context) {
    DateController date = DateController();
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: StreamBuilder(
        stream: UserData.getCurrentUser(emailUser: email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: userData.avatar != ''
                      ? Image.network(
                          userData.avatar,
                          fit: BoxFit.cover,
                          width: 38,
                          height: 38,
                        )
                      : Image.asset(
                          'assets/default_profile.png',
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        ),
                ),
                const Gap(8),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              userData.username,
                              style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: AppFontWeight.medium),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(4),
                          const Verified(width: 12),
                          const Gap(10),
                          Text(
                            date.checkDifferenceTime(date: createdAt),
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
                ),
              ],
            );
          } else {
            return const Text("Belum ada komentar");
          }
        },
      ),
    );
  }
}
