import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_article.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _searchC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void dispose() {
    _searchC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pencarian',
                        style: AppTextStyle.appbarTitle.copyWith(
                            color: AppColors.primary1, letterSpacing: -2),
                      ),
                      Gap(AppMargin.defaultMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * .7,
                            child: CustomTextFieldIcon(
                              textController: _searchC,
                              hintText: 'Cari inspirasi di sini!',
                              icon: const Icon(
                                Icons.search,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: IconButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.primary1),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(12)),
                              ),
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/icon_search.png',
                                width: 24,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppMargin.defaultMargin,
                top: 16,
                bottom: 16,
              ),
              child: Text(
                'Mungkin kamu kenal',
                style: AppTextStyle.h3.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppMargin.defaultMargin),
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyColor.withOpacity(.2),
                    width: 1,
                  ),
                ),
              ),
              child: FutureBuilder(
                future: UserData.getRandomUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          UserModel userData = snapshot.data![index];
                          return UserProfile(
                            username: userData.username,
                            avatar: userData.avatar,
                            idUser: userData.id,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text("Tunggu"),
                    );
                  }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: AppMargin.defaultMargin,
                top: 16,
                bottom: 16,
              ),
              child: Text(
                'Rekomendasi Artikel',
                style: AppTextStyle.h3.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => const CardArticle(),
            ),
          ),
        ],
      ),
    );
  }
}
