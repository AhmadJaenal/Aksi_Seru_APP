import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/user_profile.png', width: 80),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alexander K..',
                style: AppTextStyle.paragraphL.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const Gap(7),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary1,
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                  size: 12,
                ),
              ),
            ],
          ),
          const Gap(8),
          ElevatedButton.icon(
            onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
