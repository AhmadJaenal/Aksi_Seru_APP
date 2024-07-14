import 'package:aksi_seru_app/controller/user_controller.dart';
import 'package:aksi_seru_app/getX/counter_follow.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ListFollowing extends StatelessWidget {
  ListFollowing({super.key});
  FollowCounter followCounter = FollowCounter();

  List<dynamic> listFollowing = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Gap(16),
                Text(
                  'Diikuti',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: listFollowing.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> userId = listFollowing[index];
            String email = userId['user_id'];
            return FutureBuilder(
              future: UserData.getUserByEmail(email: email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel userData =
                      UserModel.fromJson(snapshot.data!.docs[0].data());
                  return CardUser(userData: userData);
                } else {
                  return const SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
