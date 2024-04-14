import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifiedCode extends StatelessWidget {
  const VerifiedCode({super.key});

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
              'Daftar',
              style: AppTextStyle.titlePrimary,
            ),
            const Gap(24),
            const CustomTextFieldIcon(
              hintText: 'Masukan code verifikasi',
              icon: Icon(
                Icons.email_outlined,
                color: AppColors.greyColor,
              ),
            ),
            const Gap(24),
            PrimaryButton(
                ontap: () => Get.toNamed('/create-password'), title: 'Lanjut'),
            const Gap(24),
            RichText(
              text: TextSpan(
                style: AppTextStyle.paragraphL
                    .copyWith(color: AppColors.greyColor),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Kode verifikasi belum dikirim? ',
                  ),
                  TextSpan(
                    text: 'Kirim ulang',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.primary1,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
