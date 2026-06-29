import 'package:masar_app/core/storage/app_preferences.dart';
import 'package:masar_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:masar_app/features/onboarding/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routePath = '/splash';
  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleSplashNavigation();
  }

  Future<void> _handleSplashNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasSeenOnboarding = await AppPreferences.hasSeenOnboarding();

    if (!mounted) return;

    if (hasSeenOnboarding) {
      context.go(LoginScreen.routePath);
    } else {
      context.go(OnboardingScreen.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _SplashBody(),
      ),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody();

  static const String _logoPath = 'assets/assets/white_logo.png';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width >= 600;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F766E),
            Color(0xFF0B5F4B),
            Color(0xFF2148B7),
          ],
          stops: [0.0, 0.48, 1.0],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(
              painter: _SplashWavePainter(),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    _logoPath,
                    width: isTablet ? 190 : 145,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'مسار',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'مساحة تشغيل ذكية للمؤسسات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 28 : 22,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: isTablet ? 72 : 58,
            child: Column(
              children: [
                Container(
                  width: isTablet ? 260 : 200,
                  height: 1.2,
                  color: Colors.white.withValues(alpha: 0.28),
                ),
                const SizedBox(height: 22),
                Text(
                  'تنظيم العمليات من مكان واحد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: isTablet ? 18 : 13,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashWavePainter extends CustomPainter {
  const _SplashWavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final solidPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.11)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final firstWave = Path()
      ..moveTo(size.width * 0.02, size.height * 0.135)
      ..cubicTo(
        size.width * 0.26,
        size.height * 0.23,
        size.width * 0.60,
        size.height * 0.04,
        size.width * 0.99,
        size.height * 0.128,
      );

    final secondWave = Path()
      ..moveTo(size.width * 0.02, size.height * 0.37)
      ..cubicTo(
        size.width * 0.30,
        size.height * 0.47,
        size.width * 0.58,
        size.height * 0.30,
        size.width * 0.99,
        size.height * 0.235,
      );

    canvas.drawPath(firstWave, solidPaint);
    canvas.drawPath(secondWave, solidPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}