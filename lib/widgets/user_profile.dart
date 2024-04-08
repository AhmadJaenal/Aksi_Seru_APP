import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              const Verified(),
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

class Verified extends StatelessWidget {
  final double width;
  const Verified({super.key, this.width = 18});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary1,
      ),
      child: Icon(
        Icons.check,
        color: AppColors.whiteColor,
        size: width * .7,
      ),
    );
  }
}

class CardCreateStories extends StatelessWidget {
  const CardCreateStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset('assets/user_profile.png', width: 80),
        Transform.translate(
          offset: const Offset(0, -23),
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary1,
              border: Border.all(
                width: 2,
                color: AppColors.whiteColor,
              ),
            ),
            child: Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: 12,
              weight: 2,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -10),
          child: Text(
            'Buat cerita',
            style: AppTextStyle.paragraphL.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        )
      ],
    );
  }
}

class CardStories extends StatelessWidget {
  const CardStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary40,
              width: 3,
            ),
            image: const DecorationImage(
              image: AssetImage('assets/user_profile.png'),
            ),
          ),
        ),
        const Gap(8),
        SizedBox(
          width: 80,
          child: Text(
            'Willie Tsdsdsdsdsd',
            style: AppTextStyle.paragraphL.copyWith(
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
