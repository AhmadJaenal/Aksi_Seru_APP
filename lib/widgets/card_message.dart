import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CardMessage extends StatelessWidget {
  const CardMessage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Get.toNamed('/room-message'),
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(
          horizontal: AppMargin.defaultMargin,
          vertical: 5,
        ),
        child: Row(
          children: [
            Image.asset('assets/user_profile.png', width: 48),
            const Gap(8),
            SizedBox(
              width: width * .5,
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: AppTextStyle.paragraphL.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Alexander Stevenson\n'),
                    const WidgetSpan(
                      child: Gap(2),
                    ),
                    TextSpan(
                      text: 'Bromo udah hijau lagi, ayo besok',
                      style: AppTextStyle.paragraphL.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: AppFontWeight.reguler,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RichText(
                maxLines: 2,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: AppTextStyle.paragraphL.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeight.reguler,
                  ),
                  children: <InlineSpan>[
                    const TextSpan(text: '20 menit\n'),
                    const WidgetSpan(
                      child: Gap(2),
                    ),
                    WidgetSpan(
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primary1,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '1',
                            style: AppTextStyle.paragraphM.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
