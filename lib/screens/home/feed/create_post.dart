import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _captionC = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
    }
    List<int> imageBytes = File(_image!.path).readAsBytesSync();
    var base64StringImage = base64Encode(imageBytes);
    imagebase64 = base64StringImage;
  }

  void dispose() {
    _captionC.dispose();
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
          padding: EdgeInsets.all(AppMargin.defaultMargin),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileTile(),
                const Gap(12),
                CustomTextArea(
                  textController: _captionC,
                  hintText: 'Share hal seru kalian hari ini, yuk!',
                ),
                const Gap(24),
                MiniButton(
                  icon: 'icon_image.png',
                  title: 'Foto',
                  ontap: () {
                    _getImageFromGallery();
                  },
                  color: AppColors.primary1,
                  iconColor: AppColors.primary1,
                  titleColor: AppColors.primary1,
                ),
                const Gap(8),
                MiniButton(
                  icon: 'icon_location.png',
                  title: 'Tambahkan lokasi',
                  ontap: () {},
                  color: AppColors.primary1,
                  iconColor: AppColors.primary1,
                  titleColor: AppColors.primary1,
                ),
                const Spacer(),
                PrimaryButton(
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      Get.toNamed(
                        '/review-post',
                        arguments: [
                          _captionC.text,
                          _image,
                          imagebase64,
                        ],
                      );
                    } else {
                      developer.log('validasi gagal');
                    }
                  },
                  title: 'Lanjut',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
