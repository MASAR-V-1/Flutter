import 'package:flutter/material.dart';

class OnboardingSmallBubble extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final IconData icon;
  final Color iconColor;

  const OnboardingSmallBubble({
    super.key,
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