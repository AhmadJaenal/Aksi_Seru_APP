import 'package:aksi_seru_app/controller/post_controller.dart';
import 'package:aksi_seru_app/models/post_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_post.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/section_comment_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:developer' as developer;

class ListPost extends StatelessWidget {
  ListPost({super.key});

  final TextEditingController _captionC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _captionC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PostController.getPostByUser();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(AppMargin.defaultMargin),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              child: Form(
                child: Row(
                  children: [
                    SizedBox(
                      width: width * .7,
                      child: CustomTextField(
                          textController: _captionC,
                          hintText: 'Share hal seru kalian hari ini, yuk!'),
                    ),
                    const Spacer(),
                    IconButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.primary1),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(12)),
                      ),
                      onPressed: () => Get.toNamed('/create-post'),
                      icon: Image.asset('assets/icon_image.png', width: 24),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .7,
              child: StreamBuilder(
                stream: PostController.getPostByUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    String caption = data.docs[0]['caption'];
                    String urlImage = data.docs[0]['urlimage'];
                    List<dynamic> comments = data.docs[0]['comment'];
                    List<dynamic> likes = data.docs[0]['comment'];
                    String updatedAt = data.docs[0]['updated_at'];
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return CardPost(
                          caption: caption,
                          comment: comments,
                          like: likes,
                          updatedAt: updatedAt,
                          urlImage: urlImage,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Belum ada postingan',
                        style: AppTextStyle.h2.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
