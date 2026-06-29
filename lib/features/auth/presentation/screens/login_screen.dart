import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_responsive_layout.dart';
import 'forgot_password_screen.dart';
import 'package:masar_app/features/manager/presentation/screens/manager_shell_screen.dart';
import 'package:masar_app/core/theme/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routePath = '/login';
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthResponsiveLayout(
      title: AppStrings.authMainTitle,
      subtitle: AppStrings.authMainSubtitle,
      sideTitle: AppStrings.loginSideTitle,
      sideSubtitle: AppStrings.loginSideSubtitle,
      sideItems: AppStrings.authSideItems,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.loginTitle,
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.loginSubtitle,
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
            const SizedBox(height: 18),

            AuthTextField(
              label: AppStrings.passwordLabel,
              hintText: AppStrings.passwordHint,
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

            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  activeColor: const Color(0xFF0B5F4B),
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                const Text(
                  AppStrings.rememberMe,
                  style: TextStyle(color: Color(0xFF374151), fontSize: 14),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.push(ForgotPasswordScreen.routePath);
                  },
                  child: const Text(
                    AppStrings.forgotPassword,
                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }

                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));

                  if (state.user.mustChangePassword) {
                    context.go(ResetPasswordScreen.routePath);
                    return;
                  }

                  if (state.user.role == 'org_admin') {
                    context.go(ManagerShellScreen.routePath);
                    return;
                  }

                  if (state.user.role == 'employee') {
                    // Temporary until we create the employee shell/dashboard.
                    context.go(ManagerShellScreen.routePath);
                    return;
                  }

                  context.go(ManagerShellScreen.routePath);
                }
              },
              builder: (context, state) {
                final isLoading = state is LoginLoading;

                return AuthPrimaryButton(
                  text: isLoading
                      ? 'جاري تسجيل الدخول...'
                      : AppStrings.loginButton,
                  icon: isLoading ? Icons.hourglass_empty : Icons.arrow_forward,
                  onPressed: isLoading ? () {} : _submit,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
