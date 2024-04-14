import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardPost extends StatelessWidget {
  CardPost({super.key});

  final TextEditingController _commentPostC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _commentPostC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
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
                              const Gap(12),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppMargin.defaultMargin),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: DangerMiniButton(
                                    icon: 'icon_dislike.png',
                                    title: 'Laporkan artikel',
                                    ontap: () {},
                                  ),
                                ),
                              ),
                              const Gap(12),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppMargin.defaultMargin),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: DangerMiniButton(
                                    icon: 'icon_block.png',
                                    title: 'Blokir Mavropanos',
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
                  child: Image.asset('assets/icon_option.png', width: 24))
            ],
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Nyaman banget taro tanaman ini di kamarNyaman banget taro tanaman ini di kamarNyaman banget taro tanaman ini di kamarNyaman banget taro tanaman ini di kamar',
              style: AppTextStyle.paragraphL.copyWith(
                color: AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(12),
          Container(
            width: double.infinity,
            height: 342,
            decoration: BoxDecoration(
              color: AppColors.greyColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  'assets/image_post.png',
                ),
              ),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Image.asset('assets/icon_liked.png', width: 24),
              const Gap(16),
              GestureDetector(
                  onTap: () {
                    sectionCommentPost(context, height, width);
                  },
                  child: Image.asset('assets/icon_comment.png', width: 24)),
              const Gap(16),
              Image.asset('assets/icon_share.png', width: 24),
            ],
          ),
          const Gap(12),
          Text(
            'Carl Guerreiro dan 120 lainnya',
            style: AppTextStyle.paragraphL.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          const Gap(16),
          Row(
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
          const Gap(16),
          Form(
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textController: _commentPostC,
                    hintText: 'Tulis komentarmu di sini..',
                  ),
                ),
                const Gap(10),
                Text(
                  'Lihat 2 komentar',
                  style: AppTextStyle.paragraphL.copyWith(
                    color: AppColors.greyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          const Gap(24)
        ],
      ),
    );
  }

  Future<dynamic> sectionCommentPost(
      BuildContext context, double height, double width) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(12),
          ),
          child: SizedBox(
            height: height * .8,
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
                        Row(
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
                        ),
                        const Gap(12),
                        Text(
                          'Ruangan ini sangat nyaman dan terang. Saya menyukai desainnya yang minimalis dan modern. Pencahayaan alami yang masuk melalui jendela membuat ruangan terasa segar dan terbuka. Furnitur yang dipilih dengan baik memberikan kesan bersih dan rapi. Saya juga menghargai ruang kosong yang menciptakan perasaan lapang dan tenang. Secara keseluruhan, ruangan ini memberikan suasana yang menyenangkan untuk bekerja atau bersantai.🍀🍂🥀🌻🌷',
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
                    delegate: SliverChildBuilderDelegate(childCount: 10,
                        (context, index) {
                  return Container(
                    color: AppColors.whiteColor,
                    padding: EdgeInsets.all(AppMargin.defaultMargin),
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
                                'Ruangan ini sangat nyaman dan terang. Saya menyukai desainnya yang minimalis dan modern. Pencahayaan alami yang masuk melalui jendela membuat ruangan terasa segar dan terbuka. Furnitur yang dipilih dengan baik memberikan kesan bersih dan rapi. Saya juga menghargai ruang kosong yang menciptakan perasaan lapang dan tenang. Secara keseluruhan, ruangan ini memberikan suasana yang menyenangkan untuk bekerja atau bersantai.🍀🍂🥀🌻🌷',
                                style: AppTextStyle.paragraphL.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: AppFontWeight.reguler),
                              ),
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text(
                                  'Suka',
                                  style: AppTextStyle.paragraphL
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                const Gap(16),
                                Text(
                                  'Balas',
                                  style: AppTextStyle.paragraphL
                                      .copyWith(color: AppColors.greyColor),
                                )
                              ],
                            ),
                            const Gap(8),
                            Text(
                              'Lihat 1 balasan',
                              style: AppTextStyle.paragraphL
                                  .copyWith(color: AppColors.blackColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }))

                // NOTE :: END CODE SECTION COMMENT POST
              ],
            ),
          ),
        );
      },
    );
  }
}
