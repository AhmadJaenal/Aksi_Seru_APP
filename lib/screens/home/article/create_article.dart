import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  @override
  Widget build(BuildContext context) {
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
          child: ListView(
            children: [
              const TitleWidget(),
              const SubTitleWidget(),
              const Gap(10),
              const ContentWidget(),
              const AddPhotoWidget(),
              const Gap(10),
              PrimaryButton(ontap: () {}, title: 'Publish'),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({
    super.key,
  });

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? image;

  String? imagebase64;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    int fileSizeInBytes = await pickedImage!.length();
    double fileSizeInKB = fileSizeInBytes / 1024;

    if (pickedImage != null && fileSizeInKB < 2000) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {
      CustomPopUp(
        icon: Icons.photo_size_select_actual_outlined,
        message: 'Ukuran foto harus kurang dari 2000kb',
        isSuccess: false,
        onTap: () {
          Get.back();
        },
        titleButton: 'Kembali',
      );
    }
    List<int> imageBytes = File(image!.path).readAsBytesSync();
    var base64StringImage = base64Encode(imageBytes);

    imagebase64 = base64StringImage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  image!,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: double.infinity,
          child: MiniButton(
            icon: 'icon_image.png',
            title: 'Tambahkan poto',
            ontap: () {
              _getImageFromGallery();
            },
          ),
        ),
      ],
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
      maxLines: 3,
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
      maxLines: 10,
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
