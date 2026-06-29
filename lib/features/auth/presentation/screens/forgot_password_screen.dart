import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:masar_app/core/theme/app_strings.dart';

import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../widgets/auth_responsive_layout.dart';
import 'login_screen.dart';

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
  String? _successMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ForgotPasswordCubit>().sendResetLink(
      email: _emailController.text.trim(),
    );
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
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              setState(() {
                _linkSent = true;
                _successMessage = state.message;
              });
            }

            if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is ForgotPasswordLoading;

            return Column(
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
                  AuthInfoBox(
                    icon: Icons.check_circle_outline,
                    text: _successMessage ?? AppStrings.resetLinkSentMessage,
                  ),
                  const SizedBox(height: 22),
                ],

                AuthPrimaryButton(
                  text: isLoading
                      ? 'جاري الإرسال...'
                      : _linkSent
                      ? AppStrings.resendResetLinkButton
                      : AppStrings.sendResetLinkButton,
                  icon: isLoading ? Icons.hourglass_empty : Icons.send_outlined,
                  onPressed: isLoading ? () {} : _sendResetLink,
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
