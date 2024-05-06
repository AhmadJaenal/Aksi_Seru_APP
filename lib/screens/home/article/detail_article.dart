import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DetailArticle extends StatelessWidget {
  const DetailArticle({super.key});

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Text(
                      '“Bertindak Lokal, Berdampak Global : Peran Individu',
                      style: AppTextStyle.titlePrimary.copyWith(
                        color: AppColors.primary1,
                        letterSpacing: -2,
                        height: 1,
                      ),
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.greyColor.withOpacity(.2)),
                          child: Text(
                            'Bencana',
                            style: AppTextStyle.paragraphM
                                .copyWith(color: AppColors.greyColor),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greyColor,
                          ),
                        ),
                        Text(
                          'Feb 23, 2023',
                          style: AppTextStyle.paragraphM
                              .copyWith(color: AppColors.greyColor),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
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
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/article.png'),
                  ),
                ),
              ),
              const Gap(16),
              // NOTE :: START CODE SUB HEADER
              Text(
                'Bertindak Lokal, Berdampak Global: Peran Individu dalam Menciptakan Perubahan Positif',
                style: AppTextStyle.h3.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
              // NOTE :: END START SUB HEADER
              const Gap(16),
              // NOTE :: START CODE SUB CONTENT
              Text(
                'Dalam era globalisasi ini, peran individu tidak hanya terbatas pada lingkup lokal, tetapi juga memiliki dampak yang signifikan pada skala global. Tindakan-tindakan yang dilakukan secara lokal oleh individu dapat menjadi kekuatan yang mendorong perubahan positif yang lebih besar di dunia. Artikel ini akan menjelajahi bagaimana bertindak lokal dapat berdampak global, serta peran penting individu dalam menciptakan perubahan yang berkelanjutan.',
                style: AppTextStyle.paragraphL.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeight.reguler,
                ),
              ),
              // NOTE :: END START SUB CONTENT
              // NOTE :: END CODE ARTICLE
            ],
          ),
        ),
      ),
    );
  }
}
