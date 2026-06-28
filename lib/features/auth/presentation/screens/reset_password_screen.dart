import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:masar_app/core/theme/app_strings.dart';

import '../widgets/auth_responsive_layout.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String routePath = '/reset-password';
  static const String routeName = 'reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;

    // Later:
    // context.read<ResetPasswordCubit>().resetPassword(...)

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.passwordChangedSuccess),
      ),
    );

    context.go(LoginScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return AuthResponsiveLayout(
      title: AppStrings.resetPasswordPageTitle,
      subtitle: AppStrings.resetPasswordPageSubtitle,
      sideTitle: AppStrings.resetPasswordSideTitle,
      sideSubtitle: AppStrings.resetPasswordSideSubtitle,
      sideItems: AppStrings.resetPasswordSideItems,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.resetPasswordTitle,
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              AppStrings.resetPasswordSubtitle,
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 30),

            AuthTextField(
              label: AppStrings.verificationCodeLabel,
              hintText: AppStrings.verificationCodeHint,
              controller: _codeController,
              keyboardType: TextInputType.number,
              icon: Icons.verified_user_outlined,
              validator: (value) {
                final code = value?.trim() ?? '';

                if (code.isEmpty) {
                  return AppStrings.verificationCodeRequired;
                }

                if (code.length < 4) {
                  return AppStrings.verificationCodeInvalid;
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            AuthTextField(
              label: AppStrings.newPasswordLabel,
              hintText: AppStrings.newPasswordHint,
              controller: _passwordController,
              isPassword: true,
              icon: Icons.lock_outline,
              validator: (value) {
                final password = value ?? '';

                if (password.isEmpty) {
                  return AppStrings.passwordRequired;
                }

                if (password.length < 8) {
                  return AppStrings.passwordTooShort;
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            AuthTextField(
              label: AppStrings.confirmPasswordLabel,
              hintText: AppStrings.confirmPasswordHint,
              controller: _confirmPasswordController,
              isPassword: true,
              icon: Icons.lock_reset_outlined,
              validator: (value) {
                final confirmPassword = value ?? '';

                if (confirmPassword.isEmpty) {
                  return AppStrings.confirmPasswordRequired;
                }

                if (confirmPassword != _passwordController.text) {
                  return AppStrings.passwordsDoNotMatch;
                }

                return null;
              },
            ),

            const SizedBox(height: 22),

            AuthPrimaryButton(
              text: AppStrings.changePasswordButton,
              icon: Icons.check_rounded,
              onPressed: _resetPassword,
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