import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  List<Widget> articleWidget = [];
  @override
  void initState() {
    super.initState();
    articleWidget = [
      const TitleWidget(),
      const SubTitleWidget(),
      const ContentWidget(),
    ];
  }

  bool isShowButton = false;
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
                  'Buat postingan',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
          child: ListView.builder(
            itemCount: articleWidget.length,
            itemBuilder: (context, index) {
              return articleWidget[index];
            },
          ),
        ),
        floatingActionButton: Column(
          children: [
            const Spacer(),
            Visibility(
              visible: isShowButton,
              child: Column(
                children: [
                  CustomIconButton(
                    icon: Icon(Icons.title, color: AppColors.primary1),
                    ontap: () {
                      setState(() {
                        articleWidget.add(
                          const TitleWidget(),
                        );
                      });
                    },
                  ),
                  CustomIconButton(
                    icon: Icon(Icons.image, color: AppColors.primary1),
                    ontap: () {
                      setState(() {
                        articleWidget.add(
                          const AddPhotoWidget(),
                        );
                      });
                    },
                  ),
                  CustomIconButton(
                    icon: Icon(Icons.keyboard_tab_rounded,
                        color: AppColors.primary1),
                    ontap: () {
                      setState(() {
                        articleWidget.add(
                          const SpaceWidget(),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            IconButton(
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
                setState(() {
                  isShowButton = !isShowButton;
                });
              },
              icon: Icon(
                Icons.add,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MiniButton(
      icon: 'icon_image.png',
      title: 'Tambahkan poto',
      ontap: () {},
    );
  }
}

class SpaceWidget extends StatelessWidget {
  const SpaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.redColor),
      readOnly: true,
      cursorColor: AppColors.greyColor,
      decoration: const InputDecoration(
        enabledBorder: InputBorder.none,
      ),
    );
  }
}

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.h3.copyWith(color: AppColors.greyColor),
      maxLines: 2,
      cursorColor: AppColors.greyColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: 'Tambahkan sub judul',
        hintStyle: AppTextStyle.h3.copyWith(color: AppColors.greyColor),
        enabledBorder: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      cursorColor: AppColors.greyColor,
      maxLines: 3,
      decoration: InputDecoration.collapsed(
        hintText: 'Ekspresikan ide dan informasi mu di sini...',
        hintStyle: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.titlePrimary.copyWith(color: AppColors.primary1),
      cursorColor: AppColors.primary1,
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: 'Judul',
        hintStyle:
            AppTextStyle.titlePrimary.copyWith(color: AppColors.primary1),
        enabledBorder: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
