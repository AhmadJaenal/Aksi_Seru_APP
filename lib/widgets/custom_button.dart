import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final Function() ontap;
  final String title;
  const PrimaryButton({
    super.key,
    required this.ontap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      onPressed: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.h3.copyWith(color: AppColors.whiteColor),
          ),
          const Gap(12),
          Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.whiteColor,
            size: 24,
          ),
        ],
      ),
    );
  }
}
