import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color primary1 = const Color(0xFFE74C3C);
  static Color primary2 = const Color(0xFFF38276);
  static Color primary3 = const Color(0xFFF38276);
  static Color primary4 = const Color(0xFFFDE5E3);

  static Color secondary1 = const Color(0xFF9B59B6);
  static Color secondary2 = const Color(0xFFE26BF5);
  static Color secondary3 = const Color(0xFFF7C2FF);
  static Color secondary4 = const Color(0xFFFDEFFC);

  static Color warning1 = const Color(0xFFFFC212);
  static Color warning2 = const Color(0xFFFFD252);
  static Color warning3 = const Color(0xFFFFE393);
  static Color warning4 = const Color(0xFFFFF9E9);

  static Color success1 = const Color(0xFF00F7BF);
  static Color success2 = const Color(0xFF5BFFCE);
  static Color success3 = const Color(0xFF98FFE0);
  static Color success4 = const Color(0xFFEAFFF8);

  static Color danger1 = const Color(0xFFFF0022);
  static Color danger2 = const Color(0xFFFF455E);

  static Color info1 = const Color(0xFF3498DB);
  static Color info2 = const Color(0xFF5BFFCE);
  static Color info3 = const Color(0xFF97F4FF);
  static Color info4 = const Color(0xFFEAFCFF);

  static Color black = const Color(0xFF111314);
  static Color black100 = const Color(0xFF2D3436);
  static Color black80 = const Color(0xFF636E72);
  static Color black60 = const Color(0xFFB2BEC3);
  static Color black40 = const Color(0xFFDFE6E9);
  static Color black20 = const Color(0xFFDFE6E9);
  static Color black10 = const Color(0xFFF7FAFC);

  static Color white = const Color(0xFFFFFFFF);
  static Color blue = const Color(0xFF0B63E5);
  static Color green = const Color(0xFFA3D139);
  static Color darkBlue = const Color(0xFF273B4A);
}

class AppTextStyle {
  static TextStyle title = GoogleFonts.manrope()
      .copyWith(fontSize: 48, fontWeight: AppWeightFont.extraBold);

  static TextStyle h1 = GoogleFonts.manrope()
      .copyWith(fontSize: 32, fontWeight: AppWeightFont.bold);
  static TextStyle h2 = GoogleFonts.manrope()
      .copyWith(fontSize: 24, fontWeight: AppWeightFont.bold);
  static TextStyle h3 = GoogleFonts.manrope()
      .copyWith(fontSize: 20, fontWeight: AppWeightFont.bold);

  static TextStyle paragraphL = GoogleFonts.manrope()
      .copyWith(fontSize: 16, fontWeight: AppWeightFont.reguler);
  static TextStyle paragraphM = GoogleFonts.manrope()
      .copyWith(fontSize: 14, fontWeight: AppWeightFont.reguler);
  static TextStyle paragraphS = GoogleFonts.manrope()
      .copyWith(fontSize: 12, fontWeight: AppWeightFont.reguler);
  static TextStyle paragraphXS = GoogleFonts.manrope()
      .copyWith(fontSize: 10, fontWeight: AppWeightFont.reguler);

  static TextStyle paragraphLBold = GoogleFonts.manrope()
      .copyWith(fontSize: 16, fontWeight: AppWeightFont.bold);
  static TextStyle paragraphMBold = GoogleFonts.manrope()
      .copyWith(fontSize: 14, fontWeight: AppWeightFont.bold);
  static TextStyle paragraphSBold = GoogleFonts.manrope()
      .copyWith(fontSize: 12, fontWeight: AppWeightFont.bold);
  static TextStyle paragraphXSBold = GoogleFonts.manrope()
      .copyWith(fontSize: 10, fontWeight: AppWeightFont.bold);

  static TextStyle paragraphSecondaryS = GoogleFonts.lexend()
      .copyWith(fontSize: 14, fontWeight: AppWeightFont.light);
}

class AppWeightFont {
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight bold = FontWeight.w700;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight medium = FontWeight.w500;
  static FontWeight reguler = FontWeight.w400;
  static FontWeight light = FontWeight.w300;
}

class AppMargin {
  static double defaultMargin = 20;
}