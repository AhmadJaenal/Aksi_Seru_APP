import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color primary1 = const Color(0xFF2F7632);
  static Color primary10 = const Color(0xFFD7E8D8);

  static Color secondary = const Color(0xFFFFFFFF);

  static Color greyColor = const Color(0xFF667085);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF1D2939);
  static Color redColor = const Color(0xFFD92D20);
  static Color roseColor = const Color(0xFFFFE4E8);
}

class AppTextStyle {
  static TextStyle titlePrimary = GoogleFonts.playfair().copyWith(
      fontSize: 48,
      fontWeight: AppFontWeight.medium,
      letterSpacing: -2,
      color: AppColors.primary1);

  static TextStyle h1 = GoogleFonts.playfair()
      .copyWith(fontSize: 32, fontWeight: AppFontWeight.bold);
  static TextStyle h2 = GoogleFonts.playfair()
      .copyWith(fontSize: 24, fontWeight: AppFontWeight.bold);
  static TextStyle h3 = GoogleFonts.inter().copyWith(fontSize: 20);

  static TextStyle paragraphL = GoogleFonts.inter()
      .copyWith(fontSize: 16, fontWeight: AppFontWeight.reguler);
  static TextStyle paragraphM = GoogleFonts.inter()
      .copyWith(fontSize: 12, fontWeight: AppFontWeight.reguler);

  static TextStyle appbarTitle = GoogleFonts.playfair().copyWith(
      fontSize: 36, fontWeight: AppFontWeight.bold, color: AppColors.primary1);
}

class AppFontWeight {
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight bold = FontWeight.w700;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight medium = FontWeight.w500;
  static FontWeight reguler = FontWeight.w400;
  static FontWeight light = FontWeight.w300;
}

class AppMargin {
  static double defaultMargin = 24;
}
