import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class CreateUsername extends StatelessWidget {
  CreateUsername({super.key});

  final TextEditingController _usernameC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _usernameC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(160),
              Text(
                'Masukan nama',
                style: AppTextStyle.titlePrimary,
              ),
              const Gap(24),
              CustomTextFieldIcon(
                textController: _usernameC,
                hintText: 'Masukan nama kamu',
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.greyColor,
                ),
              ),
              const Gap(24),
              PrimaryButton(
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    Get.toNamed('/recommendation-page');
                  } else {
                    developer.log('validasi gagal');
                  }
                },
                title: 'Lanjut',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
