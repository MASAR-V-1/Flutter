import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:masar_app/core/storage/app_preferences.dart';
import 'package:masar_app/core/theme/app_colors.dart';
import 'package:masar_app/core/theme/app_strings.dart';
import 'package:masar_app/features/auth/presentation/screens/login_screen.dart';
import 'package:masar_app/features/auth/presentation/widgets/auth_responsive_layout.dart';
import '../constants/onboarding_pages.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routePath = '/onboarding';
  static const String routeName = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const String _logoPath = 'assets/assets/white_logo.png';

  final PageController _pageController = PageController();

  int _currentIndex = 0;

  bool get _isLastPage => _currentIndex == onboardingPages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await AppPreferences.setOnboardingSeen();

    if (!mounted) return;

    context.go(LoginScreen.routePath);
  }

  void _nextPage() {
    if (_isLastPage) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isTablet = width >= 600;

            return Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 330,
                  child: AuthGradientHeader(bottomRadius: 15),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      _OnboardingHeader(
                        logoPath: _logoPath,
                        isTablet: isTablet,
                        onSkip: _finishOnboarding,
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: onboardingPages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return OnboardingPage(
                              data: onboardingPages[index],
                              isTablet: isTablet,
                            );
                          },
                        ),
                      ),
                      _OnboardingFooter(
                        pageController: _pageController,
                        pageCount: onboardingPages.length,
                        isLastPage: _isLastPage,
                        isTablet: isTablet,
                        onNext: _nextPage,
                        onDotClicked: _goToPage,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingHeader extends StatelessWidget {
  final String logoPath;
  final bool isTablet;
  final VoidCallback onSkip;

  const _OnboardingHeader({
    required this.logoPath,
    required this.isTablet,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        isTablet ? 40 : 22,
        18,
        isTablet ? 40 : 22,
        0,
      ),
      child: Row(
        children: [
          Image.asset(
            logoPath,
            width: isTablet ? 118 : 96,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
          const Spacer(),
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text(
              AppStrings.onboardingSkip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingFooter extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final bool isLastPage;
  final bool isTablet;
  final VoidCallback onNext;
  final ValueChanged<int> onDotClicked;

  const _OnboardingFooter({
    required this.pageController,
    required this.pageCount,
    required this.isLastPage,
    required this.isTablet,
    required this.onNext,
    required this.onDotClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        isTablet ? 40 : 22,
        0,
        isTablet ? 40 : 22,
        isTablet ? 34 : 24,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          children: [
            SmoothPageIndicator(
              controller: pageController,
              count: pageCount,
              axisDirection: Axis.horizontal,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xFF0B5F4B),
                dotColor: Color(0xFFD1D5DB),
                dotHeight: 9,
                dotWidth: 9,
                spacing: 8,
                expansionFactor: 3.2,
                radius: 99,
              ),
              onDotClicked: onDotClicked,
            ),
            const SizedBox(height: 24),
            AuthPrimaryButton(
              text: isLastPage
                  ? AppStrings.onboardingLogin
                  : AppStrings.onboardingNext,
              icon: Icons.arrow_forward_rounded,
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}