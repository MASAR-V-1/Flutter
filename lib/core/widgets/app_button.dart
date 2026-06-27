import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isGhost;
  final double maxWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isGhost = false,
    this.maxWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SizedBox(
          width: double.infinity,
          height: AppSpacing.fieldHeight, // Structural 48px height
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isGhost ? Colors.transparent : AppColors.primaryDeepGreen,
              foregroundColor: isGhost ? AppColors.primaryBlue : AppColors.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.mobileInput,
                side: isGhost
                    ? const BorderSide(color: AppColors.primaryBlue)
                    : BorderSide.none,
              ),
            ),
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: isGhost ? AppColors.primaryBlue : AppColors.surface,
                strokeWidth: 2,
              ),
            )
                : Text(
              text,
              style: AppTextStyles.buttonMd.copyWith(
                color: isGhost ? AppColors.primaryBlue : AppColors.surface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}