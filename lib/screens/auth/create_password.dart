import 'package:aksi_seru_app/controller/auth.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  RegisterationController registerationController =
      Get.put(RegisterationController());
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments;
    String email = data['email'];
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
              CustomTextFieldPassword(
                textController: registerationController.passwordController,
                hintText: 'Buat kata sandi',
              ),
              const Gap(24),
              CustomTextFieldPassword(
                textController: _confirmPasswordController,
                hintText: 'Ulangi kata sandi',
              ),
              const Gap(24),
              PrimaryButton(
                ontap: () {
                  if (_confirmPasswordController.text ==
                      registerationController.passwordController.text) {
                    if (formKey.currentState!.validate()) {
                      Get.offAndToNamed('/success-register', arguments: {
                        'email': email,
                        'password':
                            registerationController.passwordController.text,
                      });
                    } else {
                      developer.log('validasi gagal');
                    }
                  } else {
                    showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return const SimpleDialog(
                            title: Text('Password tidak sama'),
                            contentPadding: EdgeInsets.all(20),
                          );
                        });
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
