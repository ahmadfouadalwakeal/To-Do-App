import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

ThemeData getAppTheme() {
  return ThemeData(
      primaryColor: AppColors.primary,
      // scaffoldBackgroundColor
      scaffoldBackgroundColor: AppColors.background,
      //appBarTheme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      //text theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        displayMedium: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
        ),
        displaySmall: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.44),
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ));
}

ThemeData getAppDarkTheme() {
  return ThemeData(
      primaryColor: AppColors.red,
      // scaffoldBackgroundColor
      scaffoldBackgroundColor: AppColors.red,
      //appBarTheme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      //text theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        displayMedium: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
        ),
        displaySmall: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.44),
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ));
}
