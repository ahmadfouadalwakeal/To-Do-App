import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

ThemeData getAppLightTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    // scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.white,
    //appBarTheme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.background,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.background,
        fontSize: 16,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.background.withOpacity(.44),
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      //enabled border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //focusedBorder
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //hint text
      hintStyle: GoogleFonts.lato(
        color: AppColors.background,
        fontSize: 16,
      ),
      //fill color
      fillColor: AppColors.white,
      filled: true,
    ),
  );
}

ThemeData getAppDarkTheme() {
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
    ),
    inputDecorationTheme: InputDecorationTheme(
      //enabled border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //focusedBorder
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //hint text
      hintStyle: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16,
      ),
      //fill color
      fillColor: AppColors.background,
      filled: true,
    ),
  );
}
