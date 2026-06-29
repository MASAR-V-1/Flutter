import 'package:flutter/material.dart';

import 'package:masar_app/core/theme/app_colors.dart';
import '../models/onboarding_page_data.dart';
import 'onboarding_illustration_card.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final bool isTablet;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsetsDirectional.fromSTEB(
        isTablet ? 40 : 22,
        isTablet ? 44 : 28,
        isTablet ? 40 : 22,
        20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            children: [
              SizedBox(height: isTablet ? 28 : 16),
              OnboardingIllustrationCard(
                icon: data.icon,
                label: data.primaryLabel,
                isTablet: isTablet,
              ),
              SizedBox(height: isTablet ? 42 : 34),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: isTablet ? 34 : 28,
                  fontWeight: FontWeight.w900,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textVariant,
                  fontSize: isTablet ? 18 : 15,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}