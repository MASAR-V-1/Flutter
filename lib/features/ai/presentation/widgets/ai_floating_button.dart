import 'package:flutter/material.dart';

import 'package:masar_app/core/theme/app_colors.dart';

class AiFloatingButton extends StatelessWidget {
  final VoidCallback onTap;

  const AiFloatingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'masar-ai-agent-button',
      onPressed: onTap,
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: const Icon(Icons.auto_awesome_rounded, size: 28),
    );
  }
}
