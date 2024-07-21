import 'package:aksi_seru_app/widgets/card_shimmer.dart';

import '../../../controller/post_controller.dart';
import '../../../models/post_model.dart';
import '../../../shared/style.dart';
import '../../../widgets/card_post.dart';
import '../../../widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FeedPage extends StatelessWidget {
  FeedPage({super.key});

  final TextEditingController _captionC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _captionC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 110,
              automaticallyImplyLeading: false,
              collapsedHeight: 110,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor.withOpacity(.2),
                      width: 1,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(AppMargin.defaultMargin),
                child: Column(
                  children: [
                    Form(
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * .7,
                            child: CustomTextField(
                                textController: _captionC,
                                hintText:
                                    'Share hal seru kalian hari ini, yuk!'),
                          ),
                          const Spacer(),
                          IconButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStatePropertyAll(AppColors.primary1),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(12)),
                            ),
                            onPressed: () {
                              Get.toNamed('/create-post');
                            },
                            icon:
                                Image.asset('assets/icon_image.png', width: 24),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Gap(24),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .7,
                child: StreamBuilder<List<PostModel>>(
                  stream: PostController.getRandomPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          PostModel postData = snapshot.data![index];
                          return CardPost(postData: postData);
                        },
                      );
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const CardShimmerPost();
                        },
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
