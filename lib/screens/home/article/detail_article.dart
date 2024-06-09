import 'package:aksi_seru_app/controller/article_controller.dart';
import 'package:aksi_seru_app/widgets/card_post.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';

import '../../../models/article_model.dart';
import '../../../shared/style.dart';
import '../../../widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class DetailArticle extends StatelessWidget {
  DetailArticle({super.key});

  final TextEditingController _commentArticle = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ArticleModel articleModel = Get.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.greyColor.withOpacity(.2),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.all(AppMargin.defaultMargin),
            child: Row(
              children: [
                IconButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.primary1),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                  ),
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icon_share.png', width: 24),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 280,
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
                                'Opsi',
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(24),
                              Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.all(AppMargin.defaultMargin),
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color:
                                          AppColors.greyColor.withOpacity(.2),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MiniButton(
                                      icon: 'icon_mute.png',
                                      title: 'Bisukan notifikasi',
                                      ontap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(12),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppMargin.defaultMargin),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: DangerMiniButton(
                                    icon: 'icon_close.png',
                                    title: 'Hapus notifikasi',
                                    ontap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Image.asset('assets/icon_option.png'),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
          child: ListView(
            children: [
              // NOTE :: START CODE TITLE ARTICLE
              StreamBuilder(
                stream: ArticleController.getDetailArticle(
                    docId: articleModel.docId),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    ArticleModel dataArticle = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '“${dataArticle.title}',
                                style: AppTextStyle.titlePrimary.copyWith(
                                  color: AppColors.primary1,
                                  letterSpacing: -2,
                                  height: 1,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const Gap(12),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.greyColor
                                            .withOpacity(.2)),
                                    child: Text(
                                      'Bencana',
                                      style: AppTextStyle.paragraphM
                                          .copyWith(color: AppColors.greyColor),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  Text(
                                    dataArticle.updatedAt,
                                    style: AppTextStyle.paragraphM
                                        .copyWith(color: AppColors.greyColor),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  Text(
                                    '10 mnt baca',
                                    style: AppTextStyle.paragraphM
                                        .copyWith(color: AppColors.greyColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // NOTE :: END CODE TITLE ARTICLE

                        // NOTE :: START CODE PROFILE TILE
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [ProfileTile(), FollowButton()],
                        // ),
                        // NOTE :: END CODE PROFILE TILE
                        const Gap(16),
                        // NOTE :: START CODE ARTICLE
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(articleModel.urlImage),
                            ),
                          ),
                        ),
                        const Gap(16),
                        // NOTE :: START CODE SUB HEADER
                        Text(
                          dataArticle.subtitle,
                          style: AppTextStyle.h3.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                        // NOTE :: END START SUB HEADER
                        const Gap(16),
                        // NOTE :: START CODE SUB CONTENT
                        Text(
                          dataArticle.content,
                          style: AppTextStyle.paragraphL.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: AppFontWeight.reguler,
                          ),
                        ),
                        // NOTE :: END START SUB CONTENT
                        // NOTE :: END CODE ARTICLE
                        const Gap(16),
                        Text(
                          'Komentar',
                          style: AppTextStyle.h3.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: AppFontWeight.reguler,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 400,
                          margin: const EdgeInsets.only(bottom: 60),
                          child: ListView.builder(
                            itemCount: dataArticle.comments.length,
                            itemBuilder: (context, index) {
                              CommentModel commentModel =
                                  dataArticle.comments[index];
                              return CardComment(
                                comment: commentModel.comment,
                                createdAt: commentModel.createdAt,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: Form(
          key: formKey,
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textController: _commentArticle,
                    hintText: 'Tulis komentarmu di sini..',
                  ),
                ),
                const Gap(10),
                PrimaryMiniIconButton(
                  icon: Icon(Icons.send, color: AppColors.whiteColor),
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      CommentModel comment = CommentModel(
                        comment: _commentArticle.text,
                        createdAt: 'createdAt',
                        idUser: 2,
                      );

                      ArticleController.commentArticle(
                          docId: articleModel.docId, comment: comment);

                      _commentArticle.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
