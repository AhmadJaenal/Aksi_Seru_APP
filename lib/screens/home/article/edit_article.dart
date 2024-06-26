import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/models/article_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditArticle extends StatefulWidget {
  const EditArticle({super.key});

  @override
  State<EditArticle> createState() => _CreateArticleState();
}

final formKey = GlobalKey<FormState>();

class _CreateArticleState extends State<EditArticle> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

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
      customPopUp(
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

  final ArticleModel articleModel = Get.arguments;

  @override
  void initState() {
    titleController = TextEditingController(text: articleModel.title);
    subtitleController = TextEditingController(text: articleModel.subtitle);
    contentController = TextEditingController(text: articleModel.content);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    contentController.dispose();
    categoryController.dispose();
    super.dispose();
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
                  'Edit Artikel',
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'JUDUL TIDAK BOLEH KOSONG';
                    }
                    return null;
                  },
                  controller: titleController,
                  style: AppTextStyle.titlePrimary
                      .copyWith(color: AppColors.primary1),
                  cursorColor: AppColors.primary1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    hintText: 'Judul',
                    hintStyle: AppTextStyle.titlePrimary
                        .copyWith(color: AppColors.primary1),
                    enabledBorder: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                TextFormField(
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
                    hintStyle:
                        AppTextStyle.h3.copyWith(color: AppColors.greyColor),
                    enabledBorder: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Gap(10),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'CONTENT TIDAK BOLEH KOSONG';
                    }
                    return null;
                  },
                  controller: contentController,
                  style: AppTextStyle.paragraphL
                      .copyWith(color: AppColors.greyColor),
                  cursorColor: AppColors.greyColor,
                  maxLines: 10,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Ekspresikan ide dan informasi mu di sini...',
                    hintStyle: AppTextStyle.paragraphL
                        .copyWith(color: AppColors.greyColor),
                  ),
                ),
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
                      // ArticleController.editArticle(
                      //   id: articleModel.id,
                      //   title: titleController.text,
                      //   subtitle: subtitleController.text,
                      //   content: contentController.text,
                      //   image64: imagebase64,
                      //   category: '',
                      // );
                    }
                  },
                  title: 'Simpan Perubahan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
