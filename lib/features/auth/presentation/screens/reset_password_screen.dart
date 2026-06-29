import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:masar_app/core/theme/app_strings.dart';

import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/reset_password/reset_password_state.dart';
import '../widgets/auth_responsive_layout.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;
  final String? token;

  const ResetPasswordScreen({
    super.key,
    this.email,
    this.token,
  });

  static const String routePath = '/reset-password';
  static const String routeName = 'reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _tokenController;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool get _hasEmailFromLink =>
      widget.email != null && widget.email!.trim().isNotEmpty;

  bool get _hasTokenFromLink =>
      widget.token != null && widget.token!.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.email ?? '');
    _tokenController = TextEditingController(text: widget.token ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ResetPasswordCubit>().resetPassword(
      email: _emailController.text.trim(),
      token: _tokenController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
    );
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
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }

            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

              context.go(LoginScreen.routePath);
            }
          },
          builder: (context, state) {
            final isLoading = state is ResetPasswordLoading;

            return Column(
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

                if (!_hasEmailFromLink) ...[
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
                  const SizedBox(height: 18),
                ],

                if (!_hasTokenFromLink) ...[
                  AuthTextField(
                    label: AppStrings.verificationCodeLabel,
                    hintText: AppStrings.verificationCodeHint,
                    controller: _tokenController,
                    keyboardType: TextInputType.text,
                    icon: Icons.verified_user_outlined,
                    validator: (value) {
                      final token = value?.trim() ?? '';

                      if (token.isEmpty) {
                        return AppStrings.verificationCodeRequired;
                      }

                      if (token.length < 4) {
                        return AppStrings.verificationCodeInvalid;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                ],

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
                  text: isLoading
                      ? 'جاري تغيير كلمة السر...'
                      : AppStrings.changePasswordButton,
                  icon: isLoading ? Icons.hourglass_empty : Icons.check_rounded,
                  onPressed: isLoading ? () {} : _resetPassword,
                ),

                const SizedBox(height: 18),

                AuthBackToLoginButton(
                  onPressed: () {
                    context.go(LoginScreen.routePath);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}