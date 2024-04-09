import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CardArticle extends StatelessWidget {
  const CardArticle({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Get.toNamed('/detail-article'),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
        width: double.infinity,
        child: Row(
          children: [
            Image.asset('assets/article.png', height: width * .4),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/user_profile.png', width: 24),
                    const Gap(4),
                    SizedBox(
                      width: width * .3,
                      child: Text(
                        'Alexander Keantoa',
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
                    'Edukasi Konservasi Alam dan Lingkungan Hidup',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                Text(
                  '6 mnt baca Okt 23, 2023',
                  style: AppTextStyle.paragraphM.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
                const Gap(5),
                Row(
                  children: [
                    Container(
                      height: 26,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Edukasi',
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                    const Gap(50),
                    Image.asset('assets/icon_bookmark.png', width: 24),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                width: double.infinity,
                                height: height * .73,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MiniButton(
                                            icon: 'icon_bookmark.png',
                                            title: 'Simpan',
                                            ontap: () {},
                                          ),
                                          const Gap(12),
                                          MiniButton(
                                            icon: 'icon_share.png',
                                            title: 'Bagikan artikel',
                                            ontap: () {},
                                          ),
                                          const Gap(12),
                                          MiniButton(
                                            icon: 'icon_closed_eye.png',
                                            title: 'Sembunyikan',
                                            ontap: () {},
                                          ),
                                          const Gap(12),
                                          MiniButton(
                                            icon: 'icon_information.png',
                                            title: 'Tentang kreator',
                                            ontap: () {},
                                          ),
                                          const Gap(12),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          AppMargin.defaultMargin),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: DangerMiniButton(
                                          icon: 'icon_dislike.png',
                                          title: 'Laporkan artikel',
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
                        child:
                            Image.asset('assets/icon_option.png', width: 24)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
