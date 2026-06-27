import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppShadows {
  // MASAR uses flat tonal borders instead of heavy drop shadows

  // Level 1: Standard White surface with thin architectural 1px outline
  static BoxDecoration get level1 => BoxDecoration(
    color: AppColors.surface,
    border: Border.all(color: AppColors.outlineVariant, width: 1),
    borderRadius: AppRadius.editorial,
  );

  // Level 2: Active path highlight container
  static BoxDecoration get level2Active => BoxDecoration(
    color: AppColors.cyanHighlight.withOpacity(0.1),
    border: Border.all(color: AppColors.cyanHighlight, width: 1),
    borderRadius: AppRadius.editorial,
  );
}