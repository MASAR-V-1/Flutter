import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_responsive_layout.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routePath = '/forgot-password';
  static const String routeName = 'forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _linkSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _linkSent = true;
    });

    // Later:
    // context.read<ForgotPasswordCubit>().sendResetLink(...)
  }

  @override
  Widget build(BuildContext context) {
    return AuthResponsiveLayout(
      title: 'استعادة كلمة المرور',
      subtitle: 'أدخل بريدك الإلكتروني لإرسال رابط إعادة تعيين كلمة المرور.',
      sideTitle: 'استعادة آمنة لحسابك',
      sideSubtitle:
      'سنرسل رابط إعادة التعيين إلى البريد المرتبط بحسابك. لا تشارك الرابط مع أي شخص.',
      sideItems: const [
        'تحقق من البريد الإلكتروني',
        'رابط مؤقت وآمن',
        'إعادة تعيين كلمة المرور',
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابط إعادة التعيين.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),

            AuthTextField(
              label: 'البريد الإلكتروني',
              hintText: 'name@organization.org',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.mail_outline,
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) {
                  return 'البريد الإلكتروني مطلوب';
                }
                if (!email.contains('@')) {
                  return 'أدخل بريدًا إلكترونيًا صحيحًا';
                }
                return null;
              },
            ),

            const SizedBox(height: 22),

            if (_linkSent) ...[
              const AuthInfoBox(
                icon: Icons.check_circle_outline,
                text:
                'تم إرسال رابط إعادة تعيين كلمة المرور. تحقق من بريدك الإلكتروني واتبع التعليمات.',
              ),
              const SizedBox(height: 22),
            ],

            AuthPrimaryButton(
              text: _linkSent
                  ? 'إعادة إرسال رابط التعيين'
                  : 'إرسال رابط إعادة التعيين',
              icon: Icons.send_outlined,
              onPressed: _sendResetLink,
            ),

            const SizedBox(height: 14),

            AuthSecondaryButton(
              text: 'فتح شاشة إعادة التعيين للتجربة',
              icon: Icons.lock_reset_outlined,
              onPressed: () {
                context.push(ResetPasswordScreen.routePath);
              },
            ),

            const SizedBox(height: 18),

            Center(
              child: TextButton.icon(
                onPressed: () {
                  context.go(LoginScreen.routePath);
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'العودة إلى تسجيل الدخول',
                  style: TextStyle(
                    color: Color(0xFF0B5F4B),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}