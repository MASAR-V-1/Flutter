import 'package:flutter/material.dart';

class AppColors {
  // Brand & Identity
  static const Color primaryDeepGreen = Color(0xFF064E3B);
  static const Color operationalGreen = Color(0xFF0F766E);
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color deepBlue = Color(0xFF1E40AF);
  static const Color mintHighlight = Color(0xFF95D3BA);
  static const Color cyanHighlight = Color(0xFF9CF2E8);

  // Background & Surface
  static const Color background = Color(0xFFFAF8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFDAE2FD);

  // Text
  static const Color textPrimary = Color(0xFF131B2E);
  static const Color textVariant = Color(0xFF404944);

  // Borders & Outlines
  static const Color outline = Color(0xFF707974);
  static const Color outlineVariant = Color(0xFFBFC9C3);
  static const Color inputBorderDefault = Color(0xFFCBD5E1);

  // Status Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color success = operationalGreen;

// MASAR Brand Splash Gradient
  static const Color splashGradientStart = Color(
      0xFF036666); // Deep Institutional Teal
  static const Color splashGradientEnd = Color(0xFF1041C5); // Deep Command Blue

  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textWhiteSecondary = Color(0xB3FFFFFF); // 70% opacity white

// Extra shared aliases for dashboard and status UI
  static const Color primary = operationalGreen;
  static const Color primaryDark = primaryDeepGreen;
  static const Color secondaryBlue = primaryBlue;

  static const Color lightGreen = Color(0xFFDCEFE8);
  static const Color lightBlue = Color(0xFFDBEAFE);
  static const Color softSurface = Color(0xFFF1F5F9);

  static const Color textSecondary = textVariant;
  static const Color mutedText = Color(0xFF64748B);

  static const Color border = outlineVariant;

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFFF7ED);

  static const Color successContainer = Color(0xFFE8F7F3);
  static const Color blueContainer = Color(0xFFDBEAFE);
}