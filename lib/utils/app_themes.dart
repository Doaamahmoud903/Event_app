import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      fontFamily: "IBMPlexMono",
      primaryColor: AppColors.blueColor,
      focusColor: AppColors.darkBlueColor,
      hoverColor: AppColors.whiteColor,
      cardColor: AppColors.whiteColor,
      textTheme: TextTheme(
        headlineLarge: AppStyles.bold20Black,
        headlineMedium: AppStyles.semiBold18Black,
        headlineSmall: AppStyles.semiBold14Black,
        bodyLarge: AppStyles.bold20Blue,
        bodyMedium: AppStyles.semiBold16Black,
        displayMedium: AppStyles.bold16Blue,
        displayLarge: AppStyles.bold22black,
      ),
      scaffoldBackgroundColor: AppColors.whiteColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12white,
        unselectedLabelStyle: AppStyles.bold12white,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blueColor,
          iconTheme: IconThemeData(color: AppColors.whiteColor, size: 24)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.blueColor,
          shape: StadiumBorder(
              side: BorderSide(width: 8, color: AppColors.whiteColor))));

  static final ThemeData darkTheme = ThemeData(
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white,
          headlineSmall: AppStyles.semiBold14white,
          headlineMedium: AppStyles.semiBold18White,
          bodyLarge: AppStyles.bold20Primary,
          bodyMedium: AppStyles.bold16white,
          displayMedium: AppStyles.bold16white,
          displayLarge: AppStyles.bold22white),
      fontFamily: "IBMPlexMono",
      primaryColor: AppColors.whiteColor,
      focusColor: AppColors.blueColor,
      hoverColor: AppColors.darkBlueColor,
      cardColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.darkBlueColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12white,
        unselectedLabelStyle: AppStyles.bold12white,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBlueColor,
          iconTheme: IconThemeData(color: AppColors.whiteColor, size: 24)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.darkBlueColor,
          shape: StadiumBorder(
              side: BorderSide(width: 5, color: AppColors.whiteColor))));
}
