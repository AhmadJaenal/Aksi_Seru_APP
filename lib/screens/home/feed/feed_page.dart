import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Beranda',
                        style: AppTextStyle.appbarTitle.copyWith(
                          color: AppColors.primary1,
                        ),
                      ),
                      const Spacer(),
                      Image.asset('assets/icon_notification.png', width: 24),
                      const Gap(16),
                      Image.asset('assets/icon_chat_2.png', width: 24),
                    ],
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      SizedBox(
                        width: width * .7,
                        child: const CustomTextField(
                            hintText: 'Share hal seru kalian hari ini, yuk!'),
                      ),
                      const Spacer(),
                      IconButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primary1),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(12)),
                        ),
                        onPressed: () {},
                        icon: Image.asset('assets/icon_image.png', width: 24),
                      )
                    ],
                  )
                ],
              ),
            ),
            Gap(AppMargin.defaultMargin),
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? EdgeInsets.only(left: AppMargin.defaultMargin)
                        : index == 9
                            ? EdgeInsets.only(
                                left: 8, right: AppMargin.defaultMargin)
                            : const EdgeInsets.only(left: 8),
                    child: index == 0
                        ? const CardCreateStories()
                        : const CardStories(),
                  );
                },
              ),
            ),
            const Gap(24),
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                      const Gap(12),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
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
                                      const Gap(12),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppMargin.defaultMargin),
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
                          child:
                              Image.asset('assets/icon_option.png', width: 24))
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
                          'assets/image_post2.png',
                        ),
                      ),
                    ),
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      Image.asset('assets/icon_like.png', width: 24),
                      const Gap(16),
                      Image.asset('assets/icon_comment.png', width: 24),
                      const Gap(16),
                      Image.asset('assets/icon_share.png', width: 24),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
