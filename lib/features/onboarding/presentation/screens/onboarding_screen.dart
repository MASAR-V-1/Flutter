import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:masar_app/core/theme/app_colors.dart';
import 'package:masar_app/core/theme/app_strings.dart';
import 'package:masar_app/features/auth/presentation/screens/login_screen.dart';
import 'package:masar_app/features/auth/presentation/widgets/auth_responsive_layout.dart';
import 'package:masar_app/features/auth/presentation/widgets/auth_responsive_layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routePath = '/onboarding';
  static const String routeName = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const String _logoPath = 'assets/images/masar_logo.png';

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      title: AppStrings.onboardingTitle1,
      subtitle: AppStrings.onboardingSubtitle1,
      icon: Icons.route_outlined,
      primaryLabel: AppStrings.onboardingLabel1,
    ),
    _OnboardingPageData(
      title: AppStrings.onboardingTitle2,
      subtitle: AppStrings.onboardingSubtitle2,
      icon: Icons.verified_user_outlined,
      primaryLabel: AppStrings.onboardingLabel2,
    ),
    _OnboardingPageData(
      title: AppStrings.onboardingTitle3,
      subtitle: AppStrings.onboardingSubtitle3,
      icon: Icons.dashboard_customize_outlined,
      primaryLabel: AppStrings.onboardingLabel3,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    context.go(LoginScreen.routePath);
  }

  void _nextPage() {
    if (_currentIndex == _pages.length - 1) {
      _goToLogin();
      return;
    }

    _pageController.nextPage(
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          isTablet ? 40 : 22,
                          18,
                          isTablet ? 40 : 22,
                          0,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              _logoPath,
                              width: isTablet ? 118 : 96,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox.shrink();
                              },
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: _goToLogin,
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
                      ),

                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _pages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return _OnboardingPage(
                              data: _pages[index],
                              isTablet: isTablet,
                            );
                          },
                        ),
                      ),

                      Padding(
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
                              _DotsIndicator(
                                count: _pages.length,
                                currentIndex: _currentIndex,
                              ),
                              const SizedBox(height: 24),

                              AuthPrimaryButton(
                                text: _currentIndex == _pages.length - 1
                                    ? AppStrings.onboardingLogin
                                    : AppStrings.onboardingNext,
                                icon: Icons.arrow_forward_rounded,
                                onPressed: _nextPage,
                              ),
                            ],
                          ),
                        ),
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

class _OnboardingPage extends StatelessWidget {
  final _OnboardingPageData data;
  final bool isTablet;

  const _OnboardingPage({required this.data, required this.isTablet});

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

              _IllustrationCard(
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

class _IllustrationCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isTablet;

  const _IllustrationCard({
    required this.icon,
    required this.label,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final double size = isTablet ? 300 : 246;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 24,
            right: 24,
            child: _SmallBubble(
              width: isTablet ? 74 : 62,
              height: isTablet ? 74 : 62,
              color: const Color(0xFFE8F7F3),
              icon: Icons.check_rounded,
              iconColor: const Color(0xFF0B5F4B),
            ),
          ),

          Positioned(
            bottom: 26,
            left: 26,
            child: _SmallBubble(
              width: isTablet ? 68 : 56,
              height: isTablet ? 68 : 56,
              color: const Color(0xFFEFF2FF),
              icon: Icons.lock_outline,
              iconColor: const Color(0xFF2563EB),
            ),
          ),

          Center(
            child: Container(
              width: isTablet ? 132 : 112,
              height: isTablet ? 132 : 112,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF0B5F4B),
                    Color(0xFF176E91),
                    Color(0xFF2148B7),
                  ],
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(icon, color: Colors.white, size: isTablet ? 64 : 54),
            ),
          ),

          Positioned(
            right: 26,
            left: 26,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.auto_awesome_outlined,
                    color: Color(0xFF0B5F4B),
                    size: 19,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallBubble extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final IconData icon;
  final Color iconColor;

  const _SmallBubble({
    required this.width,
    required this.height,
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: iconColor, size: 28),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _DotsIndicator({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 9,
          height: 9,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0B5F4B) : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _OnboardingPageData {
  final String title;
  final String subtitle;
  final IconData icon;
  final String primaryLabel;

  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryLabel,
  });
}
