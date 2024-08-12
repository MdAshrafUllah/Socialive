import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';

ThemeData lightThemeDataStyle() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.foregroundColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(18),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
  );
}
