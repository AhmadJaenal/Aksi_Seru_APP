import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'dart:developer' as developer;

class ListFollowers extends StatelessWidget {
  const ListFollowers({super.key});

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
                const BackButtonCustom(),
                const Gap(16),
                Text(
                  'Followers',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: UserData.listFollowers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel userData = snapshot.data![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppMargin.defaultMargin, vertical: 5),
                      child: OtherUserProfileWidget(
                          id: userData.id,
                          username: userData.username,
                          bio: userData.bio),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
