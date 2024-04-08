import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              'Login',
              style: AppTextStyle.titlePrimary,
            ),
            const Gap(24),
            CustomTextFieldIcon(
              hintText: 'Masukan email',
              icon: Icon(
                Icons.email_outlined,
                color: AppColors.greyColor,
              ),
            ),
            const Gap(12),
            const CustomTextFieldPassword(hintText: 'Masukan kata sandi'),
            const Gap(24),
            PrimaryButton(
                ontap: () => Get.offAndToNamed('/recommendation-page'),
                title: 'Lanjut'),
            const Spacer(),
            Center(
              child: Text(
                'Belum punya akun?',
                style: AppTextStyle.paragraphL.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ),
            const Gap(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.offAndToNamed('/register'),
                  child: Text(
                    'Daftar ',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.primary1,
                    ),
                  ),
                ),
                const Gap(8),
                Icon(Icons.arrow_forward_rounded,
                    color: AppColors.primary1, size: 24)
              ],
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
