import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

class MiniButton extends StatelessWidget {
  final String icon;
  final String title;
  final Color iconColor;
  final Color titleColor;
  final Function() ontap;
  final Color color;
  const MiniButton({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor = AppColors.greyColor,
    this.titleColor = AppColors.greyColor,
    required this.ontap,
    this.color = AppColors.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ontap,
      icon: Image.asset('assets/$icon', width: 24, color: iconColor),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color.withOpacity(.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      label: Text(
        title,
        style: AppTextStyle.paragraphL.copyWith(
          color: titleColor,
        ),
      ),
    );
  }
}

class DangerMiniButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function() ontap;
  const DangerMiniButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ontap,
      icon: Image.asset('assets/$icon', width: 24),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.roseColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      label: Text(
        title,
        style: AppTextStyle.paragraphL.copyWith(
          color: AppColors.redColor,
        ),
      ),
    );
  }
}
