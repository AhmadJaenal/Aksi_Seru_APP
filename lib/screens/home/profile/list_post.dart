import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_post.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ListPost extends StatelessWidget {
  const ListPost({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: width * .7,
                    child: const CustomTextField(
                        hintText: 'Share hal seru kalian hari ini, yuk!'),
                  ),
                  const Spacer(),
                  IconButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.primary1),
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(12)),
                    ),
                    onPressed: () => Get.toNamed('/create-post'),
                    icon: Image.asset('assets/icon_image.png', width: 24),
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context, index) => const CardPost(),
          ))
        ],
      ),
    );
  }
}
