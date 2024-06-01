import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/controller/article_controller.dart';
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

final formKey = GlobalKey<FormState>();

final TextEditingController titleController = TextEditingController();
final TextEditingController subtitleController = TextEditingController();
final TextEditingController contentController = TextEditingController();
final TextEditingController categoryController = TextEditingController();

class _CreateArticleState extends State<CreateArticle> {
  File? _image;

  String? imagebase64;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    int fileSizeInBytes = await pickedImage!.length();
    double fileSizeInKB = fileSizeInBytes / 1024;

    if (pickedImage != null && fileSizeInKB < 2000) {
      setState(() {
        _image = File(pickedImage.path);
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
    List<int> imageBytes = File(_image!.path).readAsBytesSync();
    var base64StringImage = base64Encode(imageBytes);
    imagebase64 = base64StringImage;
  }

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
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const TitleWidget(),
                const SubTitleWidget(),
                const Gap(10),
                const ContentWidget(),
                _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _image!,
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
                const Gap(10),
                PrimaryButton(
                  ontap: () {
                    if (formKey.currentState!.validate() && _image != null) {
                      ArticleController.createArticle(
                        title: titleController.text,
                        subtitle: subtitleController.text,
                        category: categoryController.text,
                        content: contentController.text,
                        base64Image: imagebase64,
                      );
                    } else {
                      CustomPopUp(
                        icon: Icons.cancel_outlined,
                        isSuccess: false,
                        onTap: () => Get.back(),
                        message:
                            'Terdapat kesalahan!\nPastikan semua telah diisi dengan benar!',
                        titleButton: 'Kembali',
                      );
                    }
                  },
                  title: 'Publish',
                ),
              ],
            ),
          ),
        ),
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'SUBJUDUL TIDAK BOLEH KOSONG';
        }
        return null;
      },
      controller: subtitleController,
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'CONTENT TIDAK BOLEH KOSONG';
        }
        return null;
      },
      controller: contentController,
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'JUDUL TIDAK BOLEH KOSONG';
        }
        return null;
      },
      controller: titleController,
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
