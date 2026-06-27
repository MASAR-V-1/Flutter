import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      title: 'مرحبًا بك في مسار',
      subtitle:
      'تابع مهامك وعمليات مؤسستك من مكان واحد، بطريقة منظمة وواضحة.',
      icon: Icons.route_outlined,
      primaryLabel: 'مساحة عمل ذكية',
    ),
    _OnboardingPageData(
      title: 'وصول حسب دورك',
      subtitle:
      'ستظهر لك فقط الوحدات والمهام التي منحك مدير المؤسسة صلاحية الوصول إليها.',
      icon: Icons.verified_user_outlined,
      primaryLabel: 'صلاحيات آمنة',
    ),
    _OnboardingPageData(
      title: 'ابدأ عملك بسهولة',
      subtitle:
      'سجّل الدخول باستخدام البريد الإلكتروني أو اسم المستخدم وكلمة المرور التي فعلتها من الرابط.',
      icon: Icons.dashboard_customize_outlined,
      primaryLabel: 'جاهز للانطلاق',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    context.go('/login');
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
        backgroundColor: const Color(0xFFF5F5FF),
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
                  child: _OnboardingGradientHeader(),
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
                                'تخطي',
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

                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: _nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0B5F4B),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  child: Text(
                                    _currentIndex == _pages.length - 1
                                        ? 'تسجيل الدخول'
                                        : 'التالي',
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              if (_currentIndex == _pages.length - 1)
                                TextButton(
                                  onPressed: _goToLogin,
                                  child: const Text(
                                    'لديك حساب بالفعل؟ الدخول الآن',
                                    style: TextStyle(
                                      color: Color(0xFF0B5F4B),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
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

  const _OnboardingPage({
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
                  color: const Color(0xFF111827),
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
                  color: const Color(0xFF6B7280),
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
              child: Icon(
                icon,
                color: Colors.white,
                size: isTablet ? 64 : 54,
              ),
            ),
          ),

          Positioned(
            right: 26,
            left: 26,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.auto_awesome_outlined,
                    color: Color(0xFF0B5F4B),
                    size: 19,
                  ),
                  const SizedBox(width: 8),
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
      child: Icon(
        icon,
        color: iconColor,
        size: 28,
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _DotsIndicator({
    required this.count,
    required this.currentIndex,
  });

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
            color: isActive
                ? const Color(0xFF0B5F4B)
                : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _OnboardingGradientHeader extends StatelessWidget {
  const _OnboardingGradientHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF0F766E),
            Color(0xFF176E91),
            Color(0xFF2148B7),
          ],
        ),
      ),
      child: const CustomPaint(
        painter: _OnboardingWavePainter(),
      ),
    );
  }
}

class _OnboardingWavePainter extends CustomPainter {
  const _OnboardingWavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.11)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final firstWave = Path()
      ..moveTo(size.width * -0.05, size.height * 0.18)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.02,
        size.width * 0.36,
        size.height * 0.34,
        size.width * 0.62,
        size.height * 0.12,
      )
      ..cubicTo(
        size.width * 0.78,
        size.height * -0.02,
        size.width * 0.92,
        size.height * 0.10,
        size.width * 1.08,
        size.height * 0.04,
      );

    final secondWave = Path()
      ..moveTo(size.width * -0.08, size.height * 0.62)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.42,
        size.width * 0.35,
        size.height * 0.78,
        size.width * 0.66,
        size.height * 0.50,
      )
      ..cubicTo(
        size.width * 0.82,
        size.height * 0.36,
        size.width * 0.95,
        size.height * 0.44,
        size.width * 1.10,
        size.height * 0.32,
      );

    canvas.drawPath(firstWave, paint);
    canvas.drawPath(secondWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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