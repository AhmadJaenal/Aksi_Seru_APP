import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class Login extends StatelessWidget {
  Login({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();

  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
        child: Form(
          key: formKey,
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
                icon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.greyColor,
                ),
                textController: _emailC,
              ),
              const Gap(12),
              CustomTextFieldPassword(
                hintText: 'Masukan kata sandi',
                textController: _passwordC,
              ),
              const Gap(24),
              PrimaryButton(
                title: 'Lanjut',
                ontap: () {
                  final bool isValidEmail =
                      EmailValidator.validate(_emailC.text);
                  if (formKey.currentState!.validate() && isValidEmail) {
                    Get.offAndToNamed('/recommendation-page');
                  } else {
                    developer.log('validasi gagal');
                  }
                },
              ),
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
      ),
    );
  }
}
