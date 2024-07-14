import 'dart:io';

import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? _image;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    int fileSizeInBytes = await pickedImage!.length();
    double fileSizeInKB = fileSizeInBytes / 1024;

    if (fileSizeInKB < 2000) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  final user = Get.arguments['user'] as UserModel;

  @override
  void initState() {
    nameController = TextEditingController(text: user.name);
    bioController = TextEditingController(text: user.bio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppMargin.defaultMargin),
                child: IconButton(
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
              ),
              Text(
                'Edit Profile',
                style: AppTextStyle.appbarTitle.copyWith(
                  color: AppColors.primary1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppMargin.defaultMargin),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _getImageFromGallery();
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.greyColor,
                          width: 3,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: _image == null
                          ? const Icon(
                              CupertinoIcons.person_fill,
                              size: 34,
                              color: AppColors.greyColor,
                            )
                          : ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.file(_image!, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                const Gap(6),
                Center(
                  child: Text(
                    'Update foto profile',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Besar file < 2Mb',
                    style: AppTextStyle.paragraphL.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                const Gap(16),
                CustomTextField(
                  hintText: user.name,
                  textController: nameController,
                ),
                const Gap(12),
                CustomTextField(
                  hintText: user.bio,
                  textController: bioController,
                ),
                const Gap(16),
                PrimaryButton(
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      UserData.updateProfile(
                        image: _image,
                        name: nameController.text,
                        bio: bioController.text,
                      );
                    }
                  },
                  title: 'Simpan Perubahan',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
