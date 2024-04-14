import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoryView extends StatelessWidget {
  StoryView({super.key});

  final TextEditingController _commentStory = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _commentStory.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: height,
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/story.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Gap(AppMargin.defaultMargin),
                    Row(
                      children: [
                        Image.asset('assets/user_profile.png', width: 32),
                        const Gap(8),
                        Text(
                          'Willie Timberger',
                          style: AppTextStyle.paragraphL.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.close,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomTextFieldIcon(
                      textController: _commentStory,
                      hintText: 'Balas cerita',
                      color: AppColors.whiteColor,
                      icon: Icon(
                        Icons.insert_emoticon_outlined,
                        color: AppColors.whiteColor,
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
