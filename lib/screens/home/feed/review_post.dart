import 'dart:io';

import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ReviewPost extends StatelessWidget {
  ReviewPost({super.key});

  List<dynamic> dataPost = Get.arguments;

  PostController postController = PostController();

  @override
  Widget build(BuildContext context) {
    String caption = dataPost[0];
    File image = dataPost[1];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  'Bagikan',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppMargin.defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/user_profile.png', width: 48),
                  const Gap(8),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyle.paragraphL.copyWith(
                        color: AppColors.blackColor,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Mavropanos\n',
                        ),
                        TextSpan(
                          text: 'Artikel kreator',
                          style: AppTextStyle.paragraphM.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(4),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Verified(),
                  ),
                ],
              ),
              const Gap(12),
              Text(
                caption,
                style: AppTextStyle.paragraphL.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const Gap(12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  image,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(12),
              const Spacer(),
              PrimaryButton(
                title: 'Bagikan',
                ontap: () {
                  PostController.createpostFirebase(
                    caption: caption,
                    image: image,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
