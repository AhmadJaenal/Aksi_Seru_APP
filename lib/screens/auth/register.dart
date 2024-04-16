import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _emailC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _emailC.dispose();
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
                'Daftar',
                style: AppTextStyle.titlePrimary,
              ),
              const Gap(24),
              CustomTextFieldIcon(
                textController: _emailC,
                hintText: 'Masukan email',
                messageError: 'EMAIL TIDAK BOLEH KOSONG',
                icon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.greyColor,
                ),
              ),
              const Gap(24),
              PrimaryButton(
                title: 'Lanjut',
                ontap: () {
                  final bool isValidEmail =
                      EmailValidator.validate(_emailC.text);
                  if (formKey.currentState!.validate() && isValidEmail) {
                    Get.toNamed('/verified-code');
                  } else {
                    developer.log('validasi gagal');
                  }
                },
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Sudah punya akun?',
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
                    onTap: () => Get.offAndToNamed('/login'),
                    child: Text(
                      'Login ',
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
