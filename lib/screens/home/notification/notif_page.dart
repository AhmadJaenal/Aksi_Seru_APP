import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.greyColor.withOpacity(.2),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.all(AppMargin.defaultMargin),
            child: Row(
              children: [
                IconButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.primary1),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                  ),
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Gap(16),
                Text(
                  'Notifikasi',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icon_option.png'),
                ),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Gap(AppMargin.defaultMargin),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 4, (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppMargin.defaultMargin, vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/user_profile.png', width: 32),
                      const Gap(8),
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: AppTextStyle.paragraphL.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: AppFontWeight.reguler,
                            ),
                            children: <InlineSpan>[
                              const TextSpan(text: 'Jakyuvb Blazykowski '),
                              const WidgetSpan(
                                child: Verified(width: 12),
                              ),
                              TextSpan(
                                text: '  menyukai postingan anda',
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: AppFontWeight.reguler,
                                ),
                              ),
                              TextSpan(
                                text: '  5 detik',
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: AppFontWeight.reguler,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
