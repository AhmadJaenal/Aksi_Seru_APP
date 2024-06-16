import 'dart:io';

import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/models/post_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_popup.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late TextEditingController _captionC;

  PostModel postData = Get.arguments;

  @override
  void initState() {
    super.initState();
    _captionC = TextEditingController(text: postData.caption);
  }

  @override
  void dispose() {
    _captionC.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  File? image;

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
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Gap(16),
                Text(
                  'Edit postingan',
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
            child: ListView(
              children: [
                const ProfileTile(),
                const Gap(12),
                CustomTextArea(
                  textController: _captionC,
                  hintText: '',
                ),
                const Gap(24),
                image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GestureDetector(
                          onDoubleTap: () {},
                          child: Image.network(postData.urlImage),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image!,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                const Gap(12),
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
                const Gap(24),
                PrimaryButton(
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      PostController.updatePost(
                        docId: postData.docId,
                        caption: _captionC.text,
                        image: image,
                      );
                    } else {}
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
