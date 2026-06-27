import 'package:flutter/material.dart';

class AuthResponsiveLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final String sideTitle;
  final String sideSubtitle;
  final List<String> sideItems;

  const AuthResponsiveLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.sideTitle,
    required this.sideSubtitle,
    this.sideItems = const [],
  });

  static const String logoPath = 'assets/images/masar_logo.png';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5FF),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isDesktop = width >= 900;
            final isTablet = width >= 600 && width < 900;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: isDesktop ? 350 : 310,
                  child: const _AuthGradientHeader(),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop
                          ? 64
                          : isTablet
                          ? 40
                          : 20,
                      vertical: 28,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        Image.asset(
                          logoPath,
                          width: isDesktop ? 160 : 130,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(height: 22),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isDesktop ? 42 : 30,
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.92),
                            fontSize: isDesktop ? 18 : 15,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: isDesktop ? 42 : 32),

                        if (isDesktop)
                          _DesktopAuthCard(
                            child: child,
                            sideTitle: sideTitle,
                            sideSubtitle: sideSubtitle,
                            sideItems: sideItems,
                          )
                        else
                          _MobileAuthCard(
                            child: child,
                            sideTitle: sideTitle,
                            sideSubtitle: sideSubtitle,
                            sideItems: sideItems,
                          ),
                      ],
                    ),
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

class _AuthGradientHeader extends StatelessWidget {
  const _AuthGradientHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0B5F4B),
              Color(0xFF176E91),
              Color(0xFF2563EB),
            ],
          ),
        ),
        child: const CustomPaint(
          painter: _AuthWavePainter(),
        ),
      ),
    );
  }
}

class _AuthWavePainter extends CustomPainter {
  const _AuthWavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.11)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final wave1 = Path()
      ..moveTo(size.width * -0.05, size.height * 0.18)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.02,
        size.width * 0.33,
        size.height * 0.34,
        size.width * 0.58,
        size.height * 0.12,
      );

    final wave2 = Path()
      ..moveTo(size.width * -0.05, size.height * 0.58)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.42,
        size.width * 0.34,
        size.height * 0.75,
        size.width * 0.62,
        size.height * 0.48,
      );

    canvas.drawPath(wave1, paint);
    canvas.drawPath(wave2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DesktopAuthCard extends StatelessWidget {
  final Widget child;
  final String sideTitle;
  final String sideSubtitle;
  final List<String> sideItems;

  const _DesktopAuthCard({
    required this.child,
    required this.sideTitle,
    required this.sideSubtitle,
    required this.sideItems,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 1040,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(44),
                child: child,
              ),
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 560),
                color: const Color(0xFFEFF2FF),
                padding: const EdgeInsets.all(44),
                child: _AuthSidePanel(
                  title: sideTitle,
                  subtitle: sideSubtitle,
                  items: sideItems,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileAuthCard extends StatelessWidget {
  final Widget child;
  final String sideTitle;
  final String sideSubtitle;
  final List<String> sideItems;

  const _MobileAuthCard({
    required this.child,
    required this.sideTitle,
    required this.sideSubtitle,
    required this.sideItems,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: child,
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF2FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFDCE3FF)),
            ),
            child: _AuthSidePanel(
              title: sideTitle,
              subtitle: sideSubtitle,
              items: sideItems,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthSidePanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;

  const _AuthSidePanel({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مسار',
          style: TextStyle(
            color: const Color(0xFF0B5F4B).withOpacity(0.92),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0B5F4B),
            fontSize: 20,
            fontWeight: FontWeight.w800,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 36),
        ...items.map(
              (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE7FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Color(0xFF0B5F4B),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xFF374151),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AuthTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.icon,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        )
            : null,
        filled: true,
        fillColor: const Color(0xFFFAFAFF),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF0B5F4B),
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDC2626)),
        ),
      ),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B5F4B),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class AuthSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AuthSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF0B5F4B),
          side: const BorderSide(color: Color(0xFF0B5F4B), width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class AuthInfoBox extends StatelessWidget {
  final String text;
  final IconData icon;

  const AuthInfoBox({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF2FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE3FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}