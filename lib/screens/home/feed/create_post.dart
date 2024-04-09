import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                const Gap(16),
                Text(
                  'Buat postingan',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppMargin.defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileTile(),
              const Gap(12),
              const CustomTextArea(
                  hintText: 'Share hal seru kalian hari ini, yuk!'),
              const Gap(24),
              MiniButton(
                icon: 'icon_image.png',
                title: 'Foto / Video',
                ontap: () {},
                color: AppColors.primary1,
                iconColor: AppColors.primary1,
                titleColor: AppColors.primary1,
              ),
              const Gap(8),
              MiniButton(
                icon: 'icon_location.png',
                title: 'Tambahkan lokasi',
                ontap: () {},
                color: AppColors.primary1,
                iconColor: AppColors.primary1,
                titleColor: AppColors.primary1,
              ),
              const Spacer(),
              PrimaryButton(
                  ontap: () => Get.toNamed('/review-post'), title: 'Lanjut')
            ],
          ),
        ),
      ),
    );
  }
}
