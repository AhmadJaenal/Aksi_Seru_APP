import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateUsername extends StatelessWidget {
  const CreateUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(160),
            Text(
              'Masukan nama',
              style: AppTextStyle.titlePrimary,
            ),
            const Gap(24),
            const CustomTextFieldIcon(
              hintText: 'Masukan nama kamu',
              icon: Icon(
                Icons.account_circle_outlined,
                color: AppColors.greyColor,
              ),
            ),
            const Gap(24),
            PrimaryButton(
                ontap: () => Get.toNamed('/recommendation-page'),
                title: 'Lanjut'),
          ],
        ),
      ),
    );
  }
}
