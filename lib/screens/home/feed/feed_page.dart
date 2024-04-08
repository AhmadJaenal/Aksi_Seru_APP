import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_post.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 310,
              automaticallyImplyLeading: false,
              collapsedHeight: 80,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor.withOpacity(.2),
                      width: 1,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(AppMargin.defaultMargin),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Beranda',
                          style: AppTextStyle.appbarTitle.copyWith(
                            color: AppColors.primary1,
                          ),
                        ),
                        const Spacer(),
                        Image.asset('assets/icon_notification.png', width: 24),
                        const Gap(16),
                        Image.asset('assets/icon_chat_2.png', width: 24),
                      ],
                    ),
                    const Gap(24),
                    Row(
                      children: [
                        SizedBox(
                          width: width * .7,
                          child: const CustomTextField(
                              hintText: 'Share hal seru kalian hari ini, yuk!'),
                        ),
                        const Spacer(),
                        IconButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.primary1),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(12)),
                          ),
                          onPressed: () {},
                          icon: Image.asset('assets/icon_image.png', width: 24),
                        )
                      ],
                    )
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size(width, 140),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  padding: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: AppColors.greyColor.withOpacity(.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0
                            ? EdgeInsets.only(left: AppMargin.defaultMargin)
                            : index == 9
                                ? EdgeInsets.only(
                                    left: 8, right: AppMargin.defaultMargin)
                                : const EdgeInsets.only(left: 8),
                        child: index == 0
                            ? const CardCreateStories()
                            : const CardStories(),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Gap(24),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const CardPost(),
                childCount: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
