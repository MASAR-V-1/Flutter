import 'package:flutter/material.dart';

import 'onboarding_small_bubble.dart';

class OnboardingIllustrationCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isTablet;

  const OnboardingIllustrationCard({
    super.key,
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
            color: Colors.black.withValues(alpha: 0.10),
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
            child: OnboardingSmallBubble(
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
            child: OnboardingSmallBubble(
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