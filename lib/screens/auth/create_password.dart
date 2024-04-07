import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

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
            const CustomTextFieldPassword(hintText: 'Buat kata sandi'),
            const Gap(24),
            const CustomTextFieldPassword(hintText: 'Buat kata sandi'),
            const Gap(24),
            PrimaryButton(ontap: () {}, title: 'Lanjut'),
          ],
        ),
      ),
    );
  }
}
