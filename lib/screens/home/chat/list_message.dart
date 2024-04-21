import 'package:aksi_seru_app/shared/style.dart';
import 'package:aksi_seru_app/widgets/card_message.dart';
import 'package:flutter/material.dart';

class ListMessage extends StatelessWidget {
  const ListMessage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CardMessage();
        },
      ),
    );
  }
}
