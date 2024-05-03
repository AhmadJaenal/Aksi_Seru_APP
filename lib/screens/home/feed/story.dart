import 'dart:async';

import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  final TextEditingController _commentStory = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late PageController _pageController;
  int _currentPageIndex = 0;
  final int _numPages = 3; // Jumlah halaman

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    startAutoSlide();
  }

  void startAutoSlide() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPageIndex < _numPages - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      if (_currentPageIndex == (_numPages - 1)) {
        _currentPageIndex = 0;
        Get.offAllNamed('/feed-page');
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  bool _isAnimating = true;

  void dispose() {
    _pageController.dispose();
    _commentStory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView.builder(
          itemCount: 4,
          controller: _pageController,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                GestureDetector(
                  onLongPressCancel: () {
                    setState(() {
                      _isAnimating = true;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      _isAnimating = false;
                    });
                  },
                  child: Container(
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
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            animation: _isAnimating,
                            lineHeight: 2.0,
                            animationDuration: 5000,
                            percent: 1,
                            progressColor: AppColors.primary40,
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
