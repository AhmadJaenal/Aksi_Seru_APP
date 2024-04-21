import 'package:aksi_seru_app/controller/auth.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class CreateUsername extends StatelessWidget {
  CreateUsername({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
  }

  RegisterationController registerationController =
      Get.put(RegisterationController());

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
                textController: registerationController.nameController,
                hintText: 'Masukan nama kamu',
                messageError: 'NAMA TIDAK BOLEH KOSONG',
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.greyColor,
                ),
              ),
              const Gap(16),
              CustomTextFieldIcon(
                textController: registerationController.usernameController,
                hintText: 'Masukan nama username kamu',
                messageError: 'USERNAME TIDAK BOLEH KOSONG',
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.greyColor,
                ),
              ),
              const Gap(24),
              PrimaryButton(
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    developer.log('create username');
                    registerationController.registerWithEmail();
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
