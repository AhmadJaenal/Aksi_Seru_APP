import 'package:aksi_seru_app/getX/counter_follow_user.dart';
import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ListFollowing extends StatelessWidget {
  const ListFollowing({super.key});

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
        // body: FutureBuilder(
        //   future: UserData.listFollowing(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        //         return GetX<ListFollowingCounter>(
        //           builder: (controller) {
        //             return ListView.builder(
        //               physics: const BouncingScrollPhysics(),
        //               itemCount: controller.length,
        //               itemBuilder: (context, index) {
        //                 UserModel userData = snapshot.data![index];
        //                 return Padding(
        //                   padding: EdgeInsets.symmetric(
        //                       horizontal: AppMargin.defaultMargin, vertical: 5),
        //                   child: SizedBox(
        //                     width: 128,
        //                     child: Row(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Image.asset('assets/user_profile.png',
        //                             width: 60),
        //                         const Gap(8),
        //                         Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.center,
        //                               children: [
        //                                 Text(
        //                                   userData.username,
        //                                   style:
        //                                       AppTextStyle.paragraphL.copyWith(
        //                                     color: AppColors.blackColor,
        //                                   ),
        //                                 ),
        //                                 const Gap(7),
        //                                 const Verified(),
        //                               ],
        //                             ),
        //                             Text(
        //                               userData.bio,
        //                               style: AppTextStyle.paragraphL.copyWith(
        //                                 color: AppColors.blackColor,
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                         const Spacer(),
        //                         // UnFollowButton(
        //                         //   onTap: () {
        //                         //     UserData.unFollowUser(
        //                         //       idUser: userData.id.toString(),
        //                         //     );
        //                         //   },
        //                         // ),
        //                       ],
        //                     ),
        //                   ),
        //                 );
        //               },
        //             );
        //           },
        //         );
        //       } else {
        //         return Center(
        //           child: Text(
        //             'Tidak ada yang diikuti',
        //             style: AppTextStyle.paragraphL.copyWith(
        //               color: AppColors.blackColor,
        //             ),
        //           ),
        //         );
        //       }
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
      ),
    );
  }
}

final CounterFollowUser counterFollowUser = Get.put(CounterFollowUser());
final ListFollowingCounter listFollowersCounter =
    Get.put(ListFollowingCounter());
