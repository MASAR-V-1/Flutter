import 'package:flutter/material.dart';

import 'package:masar_app/core/theme/app_strings.dart';
import '../models/onboarding_page_data.dart';

const List<OnboardingPageData> onboardingPages = [
  OnboardingPageData(
    title: AppStrings.onboardingTitle1,
    subtitle: AppStrings.onboardingSubtitle1,
    icon: Icons.route_outlined,
    primaryLabel: AppStrings.onboardingLabel1,
  ),
  OnboardingPageData(
    title: AppStrings.onboardingTitle2,
    subtitle: AppStrings.onboardingSubtitle2,
    icon: Icons.verified_user_outlined,
    primaryLabel: AppStrings.onboardingLabel2,
  ),
  OnboardingPageData(
    title: AppStrings.onboardingTitle3,
    subtitle: AppStrings.onboardingSubtitle3,
    icon: Icons.dashboard_customize_outlined,
    primaryLabel: AppStrings.onboardingLabel3,
  ),
];