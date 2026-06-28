import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:masar_app/core/theme/app_strings.dart';

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
      title: AppStrings.forgotPasswordPageTitle,
      subtitle: AppStrings.forgotPasswordPageSubtitle,
      sideTitle: AppStrings.forgotPasswordSideTitle,
      sideSubtitle: AppStrings.forgotPasswordSideSubtitle,
      sideItems: AppStrings.forgotPasswordSideItems,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.forgotPasswordTitle,
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              AppStrings.forgotPasswordSubtitle,
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 30),

            AuthTextField(
              label: AppStrings.emailLabel,
              hintText: AppStrings.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.mail_outline,
              validator: (value) {
                final email = value?.trim() ?? '';

                if (email.isEmpty) {
                  return AppStrings.emailRequired;
                }

                if (!email.contains('@')) {
                  return AppStrings.emailInvalid;
                }

                return null;
              },
            ),

            const SizedBox(height: 22),

            if (_linkSent) ...[
              const AuthInfoBox(
                icon: Icons.check_circle_outline,
                text: AppStrings.resetLinkSentMessage,
              ),
              const SizedBox(height: 22),
            ],

            AuthPrimaryButton(
              text: _linkSent
                  ? AppStrings.resendResetLinkButton
                  : AppStrings.sendResetLinkButton,
              icon: Icons.send_outlined,
              onPressed: _sendResetLink,
            ),

            const SizedBox(height: 14),

            AuthSecondaryButton(
              text: AppStrings.openResetPasswordDemo,
              icon: Icons.lock_reset_outlined,
              onPressed: () {
                context.push(ResetPasswordScreen.routePath);
              },
            ),

            const SizedBox(height: 18),

            AuthBackToLoginButton(
              onPressed: () {
                context.go(LoginScreen.routePath);
              },
            ),
          ],
        ),
      ),
    );
  }
}