import 'package:aksi_seru_app/shared/style.dart';
import 'package:flutter/material.dart';

class CustomTextFieldIcon extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Color color;
  final String messageError;
  final TextEditingController textController;
  const CustomTextFieldIcon(
      {super.key,
      required this.hintText,
      required this.icon,
      this.messageError = 'DATA TIDAK BOLEH KOSONG',
      this.color = AppColors.greyColor,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return messageError;
        }
        return null;
      },
      controller: textController,
      style: AppTextStyle.paragraphL.copyWith(color: color),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: icon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.paragraphL.copyWith(color: color),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'DATA TIDAK BOLEH KOSONG';
        }
        return null;
      },
      controller: textController,
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyColor),
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
  final TextEditingController textController;
  const CustomTextFieldPassword({
    super.key,
    required this.hintText,
    required this.textController,
  });

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
          return 'PASSWORD TIDAK BOLEH KOSONG';
        }
        return null;
      },
      controller: widget.textController,
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      obscureText: _showPassword ? true : false,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: _showPassword
              ? Image.asset('assets/icon_closed_eye.png', width: 24)
              : const Icon(
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
        prefixIcon:
            const Icon(Icons.vpn_key_outlined, color: AppColors.greyColor),
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

class CustomTextArea extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  const CustomTextArea(
      {super.key, required this.hintText, required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 10,
      validator: (value) {
        if (value!.isEmpty) {
          return 'DATA TIDAK BOLEH KOSONG';
        }
        return null;
      },
      controller: textController,
      style: AppTextStyle.paragraphL.copyWith(color: AppColors.greyColor),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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

class CustomTextFieldMessage extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Color color;
  final String messageError;
  final TextEditingController textController;
  const CustomTextFieldMessage(
      {super.key,
      required this.hintText,
      required this.icon,
      this.messageError = 'DATA TIDAK BOLEH KOSONG',
      this.color = AppColors.greyColor,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return messageError;
        }
        return null;
      },
      controller: textController,
      style: AppTextStyle.paragraphL.copyWith(color: color),
      textAlignVertical: TextAlignVertical.bottom,
      cursorColor: AppColors.primary1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: icon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.paragraphL.copyWith(color: color),
      ),
    );
  }
}
