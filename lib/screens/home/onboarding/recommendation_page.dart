import '../../../controller/user_controller.dart';
import '../../../getX/show_recommend_user.dart';
import '../../../models/user_model.dart';
import '../../../shared/style.dart';
import '../../../widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  static String myId = '';

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final ShowRecommendUserState showRecommendUser =
      Get.put(ShowRecommendUserState());

  String myId = "";
  Future<void> getEmailId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    setState(() {
      myId = email!;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmailId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(390),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppMargin.defaultMargin),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor.withOpacity(.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Rekomendasi',
                      style: AppTextStyle.appbarTitle.copyWith(
                        color: AppColors.primary1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAndToNamed('/nav-bar'),
                      child: Text(
                        'Nanti aja',
                        style: AppTextStyle.paragraphL.copyWith(
                          color: AppColors.primary1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(16),
              Padding(
                padding: EdgeInsets.only(left: AppMargin.defaultMargin),
                child: Text(
                  'Saran pengguna',
                  style: AppTextStyle.h3.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
              const Gap(16),
              Container(
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor.withOpacity(.2),
                      width: 1,
                    ),
                  ),
                ),
                child: StreamBuilder(
                  stream: UserData.getRandomUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          UserModel userData = snapshot.data![index];
                          bool isFollowing = userData.followers.any((user) =>
                              user['user_id'] == RecommendationPage.myId);
                          return UserProfile(
                              userData: userData, isFollow: isFollowing);
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const Gap(8),
            ],
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            // return CardArticle();
            return const Text('');
          },
        ),
      ),
    );
  }
}
