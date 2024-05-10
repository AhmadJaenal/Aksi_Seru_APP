import 'package:aksi_seru_app/controller/user.dart';
import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListFollowers extends StatefulWidget {
  const ListFollowers({super.key});

  @override
  State<ListFollowers> createState() => _ListFollowersState();
}

class _ListFollowersState extends State<ListFollowers> {
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
                  'Pengikut',
                  style: AppTextStyle.appbarTitle.copyWith(
                    color: AppColors.primary1,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: StreamBuilder(
          stream: UserData.listFollowers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  UserModel userData = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppMargin.defaultMargin, vertical: 5),
                    child: SizedBox(
                      width: 128,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/user_profile.png', width: 60),
                          const Gap(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userData.username,
                                    style: AppTextStyle.paragraphL.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  const Gap(7),
                                  const Verified(),
                                ],
                              ),
                              Text(
                                userData.bio,
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          UnFollowButton(
                            onTap: () {
                              setState(() {
                                UserData.deleteFollowers(
                                  idUser: userData.id.toString(),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'Tidak ada yang diikuti',
                  style: AppTextStyle.paragraphL.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
