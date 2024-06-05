import 'package:aksi_seru_app/controller/user_controller.dart';
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

class PrimaryMiniIconButton extends StatelessWidget {
  final Icon icon;
  final Function() onTap;
  const PrimaryMiniIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(AppColors.primary1),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
      ),
      onPressed: onTap,
      icon: icon,
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

class FollowButton extends StatefulWidget {
  final Function() onTap;
  const FollowButton({super.key, required this.onTap});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onTap,
      icon: Icon(Icons.add, color: AppColors.whiteColor),
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(97, 40),
        elevation: 0,
        backgroundColor: AppColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      label: Text(
        'Ikuti',
        style: AppTextStyle.paragraphL.copyWith(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class UnFollowButton extends StatefulWidget {
  final Function() onTap;
  const UnFollowButton({super.key, required this.onTap});

  @override
  State<UnFollowButton> createState() => _UnFollowButtonState();
}

class _UnFollowButtonState extends State<UnFollowButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onTap,
      icon: Icon(Icons.remove, color: AppColors.whiteColor),
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(110, 40),
        elevation: 0,
        backgroundColor: AppColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      label: Text(
        'Hapus',
        style: AppTextStyle.paragraphL.copyWith(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Function() ontap;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: IconButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          backgroundColor:
              MaterialStatePropertyAll(AppColors.greyColor.withOpacity(.3)),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
        ),
        onPressed: ontap,
        icon: icon,
      ),
    );
  }
}

class BackButtonCustom extends StatefulWidget {
  const BackButtonCustom({super.key});

  @override
  State<BackButtonCustom> createState() => _BackButtonCustomState();
}

class _BackButtonCustomState extends State<BackButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(AppColors.primary1),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
      ),
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Icons.arrow_back_rounded,
        color: AppColors.whiteColor,
      ),
    );
  }
}
