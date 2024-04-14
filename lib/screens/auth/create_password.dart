import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final TextEditingController _passwordC = TextEditingController();
  final TextEditingController _confirmPasswordC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _passwordC.dispose();
    _confirmPasswordC.dispose();
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
                'Daftar',
                style: AppTextStyle.titlePrimary,
              ),
              const Gap(24),
              CustomTextFieldPassword(
                textController: _passwordC,
                hintText: 'Buat kata sandi',
              ),
              const Gap(24),
              CustomTextFieldPassword(
                textController: _confirmPasswordC,
                hintText: 'Ulangi kata sandi',
              ),
              const Gap(24),
              PrimaryButton(
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    Get.offAndToNamed('/success-register');
                  } else {
                    print('validasi gagal');
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
