import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  const CustomTextField(
      {super.key, required this.hintText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'DATA TIDAK BOLEH KOSONG';
        }
        return null;
      },
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      decoration: InputDecoration(
        prefixIcon: icon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary1, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      ),
    );
  }
}

class CustomTextFieldPassword extends StatefulWidget {
  final String hintText;
  const CustomTextFieldPassword({super.key, required this.hintText});

  @override
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'DATA TIDAK BOLEH KOSONG';
        }
        return null;
      },
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      obscureText: _showPassword ? true : false,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: _showPassword
              ? Image.asset('assets/icon_closed_eye.png', width: 24)
              : Icon(
                  Icons.remove_red_eye_outlined,
                  size: 24,
                  color: AppColors.greyColor,
                ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
        prefixIcon: Icon(Icons.vpn_key_outlined, color: AppColors.greyColor),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary1, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.hintText,
        hintStyle: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      ),
    );
  }
}
