import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Future<dynamic> customPopUp({
  String? message,
  String? titleButton,
  Function()? onTap,
  bool isSuccess = true,
  IconData? icon,
}) {
  return showModalBottomSheet(
    context: Get.context!,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        width: double.infinity,
        height: 300,
        margin: EdgeInsets.all(AppMargin.defaultMargin),
        padding: EdgeInsets.all(AppMargin.defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
        ),
        child: Column(
          children: [
            Icon(
              icon!,
              color: isSuccess ? AppColors.primary1 : AppColors.redColor,
              size: 100,
            ),
            const Gap(16),
            Text(
              message!,
              style: AppTextStyle.h3.copyWith(
                color: isSuccess ? AppColors.primary1 : AppColors.redColor,
              ),
            ),
            const Spacer(),
            PrimaryButton(ontap: onTap!, title: titleButton!)
          ],
        ),
      );
    },
  );
}
