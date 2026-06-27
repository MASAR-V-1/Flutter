import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryDeepGreen,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryDeepGreen,
        secondary: AppColors.primaryBlue,
        error: AppColors.error,
        surface: AppColors.surface,
      ),
      fontFamily: AppTextStyles.fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDeepGreen,
        foregroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mobileInput,
          borderSide: const BorderSide(color: AppColors.inputBorderDefault, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mobileInput,
          borderSide: const BorderSide(color: AppColors.inputBorderDefault, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mobileInput,
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mobileInput,
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
      ),
    );
  }
}