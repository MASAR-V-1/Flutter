import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? indicatorColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsetsDirectional.all(AppSpacing.m),
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.editorial,
        // Use a single BorderDirectional for RTL support instead of Border.all
        border: BorderDirectional(
          top: const BorderSide(color: AppColors.outlineVariant, width: 1),
          end: const BorderSide(color: AppColors.outlineVariant, width: 1),
          bottom: const BorderSide(color: AppColors.outlineVariant, width: 1),
          start: indicatorColor != null
              ? BorderSide(color: indicatorColor!, width: 4)
              : const BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: ClipRRect(
        borderRadius: AppRadius.editorial,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}