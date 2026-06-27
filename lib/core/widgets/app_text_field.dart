import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final String? errorText;
  final double maxWidth;

  const AppTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.errorText,
    this.maxWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.labelSm),
            const SizedBox(height: AppSpacing.xs),
            TextFormField(
              controller: controller,
              obscureText: isPassword,
              style: AppTextStyles.bodyMd,
              decoration: InputDecoration(
                hintText: hintText,
                errorText: errorText,
                // Ensures exactly 48px minimum height but expands for Laravel validation errors
                constraints: const BoxConstraints(
                  minHeight: AppSpacing.fieldHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}