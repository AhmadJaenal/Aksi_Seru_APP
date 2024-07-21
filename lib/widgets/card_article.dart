import '../controller/article_controller.dart';
import '../controller/user_controller.dart';
import '../models/article_model.dart';
import '../models/user_model.dart';
import '../shared/style.dart';
import 'custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardArticle extends StatelessWidget {
  final ArticleModel article;
  final String email;
  const CardArticle({super.key, required this.article, required this.email});

  Future<String?> getMyEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Get.toNamed('/detail-article', arguments: article),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                article.urlImage,
                width: width * .4,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FutureBuilder(
                      future: UserData.getUserByEmail(email: article.userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserModel userData =
                              UserModel.fromJson(snapshot.data!.docs[0].data());
                          return userData.avatar != ""
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    image: DecorationImage(
                                      image: NetworkImage(userData.avatar),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  'assets/default_profile.png',
                                  fit: BoxFit.cover,
                                  width: 24,
                                  height: 24,
                                );
                        } else {
                          return Image.asset(
                            'assets/default_profile.png',
                            fit: BoxFit.cover,
                            width: 24,
                            height: 24,
                          );
                        }
                      },
                    ),
                    const Gap(4),
                    SizedBox(
                      width: width * .3,
                      child: Text(
                        article.title,
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.blackColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(7),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary1,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                SizedBox(
                  width: 160,
                  height: 62,
                  child: Text(
                    article.content,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 75,
                      height: 40,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        article.updatedAt,
                        style: AppTextStyle.paragraphM.copyWith(
                          color: AppColors.greyColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Gap(70),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              width: double.infinity,
                              height: height * .4,
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
                                        MiniButton(
                                          icon: 'icon_edit.png',
                                          title: 'Edit Article',
                                          ontap: () {
                                            Get.toNamed('/edit-article',
                                                arguments: article);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(AppMargin.defaultMargin),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: DangerMiniButton(
                                        icon: 'icon_delete.png',
                                        title: 'Hapus Artikel',
                                        ontap: () {
                                          confirmDeletePost(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: FutureBuilder<String?>(
                        future: getMyEmail(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String? myEmail = snapshot.data;
                            return email == myEmail
                                ? Image.asset('assets/icon_option.png',
                                    width: 24)
                                : const SizedBox();
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> confirmDeletePost(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 32),
          margin: EdgeInsets.all(AppMargin.defaultMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hapus Postingan",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              const Gap(9),
              Text(
                "Apakah Anda yakin ingin hapus postingan ini?",
                style: AppTextStyle.paragraphL.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: MiniButton(
                        icon: 'icon_block.png',
                        title: 'Kembali',
                        ontap: () {
                          Get.back();
                        }),
                  ),
                  const Gap(8),
                  Expanded(
                    child: DangerMiniButton(
                      icon: 'icon_block.png',
                      title: 'Hapus',
                      ontap: () {
                        // ArticleController.deleteArticle(id: article.id);
                        ArticleController.deleteArticle(docId: article.docId);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
