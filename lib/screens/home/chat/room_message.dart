import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/custom_button.dart';
import 'package:aksi_seru_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RoomMessage extends StatefulWidget {
  RoomMessage({super.key});

  @override
  State<RoomMessage> createState() => _RoomMessageState();
}

class _RoomMessageState extends State<RoomMessage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Gap(16),
                SizedBox(
                  width: width * .5,
                  child: Text(
                    'Alexander',
                    style: AppTextStyle.appbarTitle.copyWith(
                      color: AppColors.primary1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 280,
                          child: Column(
                            children: [
                              const Gap(16),
                              Container(
                                width: 60,
                                height: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.greyColor,
                                ),
                              ),
                              const Gap(24),
                              Text(
                                'Opsi',
                                style: AppTextStyle.paragraphL.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const Gap(24),
                              Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.all(AppMargin.defaultMargin),
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color:
                                          AppColors.greyColor.withOpacity(.2),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MiniButton(
                                      icon: 'icon_mute.png',
                                      title: 'Bisukan notifikasi',
                                      ontap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(12),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppMargin.defaultMargin),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: DangerMiniButton(
                                    icon: 'icon_close.png',
                                    title: 'Hapus notifikasi',
                                    ontap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Image.asset('assets/icon_option.png'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargin.defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * .7,
                child: CustomTextFieldMessage(
                  hintText: 'Tulis pesan',
                  icon: const Icon(Icons.insert_emoticon_outlined,
                      color: AppColors.greyColor),
                  textController: messageController,
                ),
              ),
              IconButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(AppColors.primary1),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                ),
                onPressed: () {},
                icon: Image.asset('assets/icon_send.png', width: 24),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
