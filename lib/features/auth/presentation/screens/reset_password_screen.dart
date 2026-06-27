import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        content: Text('تم تغيير كلمة المرور بنجاح'),
      ),
    );

    context.go(LoginScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return AuthResponsiveLayout(
      title: 'تعيين كلمة مرور جديدة',
      subtitle: 'أدخل رمز التحقق وكلمة المرور الجديدة للمتابعة.',
      sideTitle: 'حماية حساب المؤسسة',
      sideSubtitle:
      'اختر كلمة مرور قوية لحماية بيانات المؤسسة ومساحة العمل الخاصة بها.',
      sideItems: const [
        '8 أحرف على الأقل',
        'يفضل استخدام رقم ورمز خاص',
        'لا تستخدم كلمة مرور مشتركة',
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'إعادة تعيين كلمة المرور',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'أدخل رمز التحقق المرسل إلى بريدك ثم اختر كلمة مرور جديدة.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),

            AuthTextField(
              label: 'رمز التحقق',
              hintText: 'أدخل رمز التحقق',
              controller: _codeController,
              keyboardType: TextInputType.number,
              icon: Icons.verified_user_outlined,
              validator: (value) {
                final code = value?.trim() ?? '';
                if (code.isEmpty) {
                  return 'رمز التحقق مطلوب';
                }
                if (code.length < 4) {
                  return 'رمز التحقق غير صحيح';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            AuthTextField(
              label: 'كلمة المرور الجديدة',
              hintText: 'أدخل كلمة المرور الجديدة',
              controller: _passwordController,
              isPassword: true,
              icon: Icons.lock_outline,
              validator: (value) {
                final password = value ?? '';
                if (password.isEmpty) {
                  return 'كلمة المرور مطلوبة';
                }
                if (password.length < 8) {
                  return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            AuthTextField(
              label: 'تأكيد كلمة المرور',
              hintText: 'أعد إدخال كلمة المرور',
              controller: _confirmPasswordController,
              isPassword: true,
              icon: Icons.lock_reset_outlined,
              validator: (value) {
                final confirmPassword = value ?? '';
                if (confirmPassword.isEmpty) {
                  return 'تأكيد كلمة المرور مطلوب';
                }
                if (confirmPassword != _passwordController.text) {
                  return 'كلمتا المرور غير متطابقتين';
                }
                return null;
              },
            ),

            const SizedBox(height: 22),

            const AuthInfoBox(
              text:
              'بعد تغيير كلمة المرور سيتم إعادتك إلى شاشة تسجيل الدخول لاستخدام كلمة المرور الجديدة.',
            ),

            const SizedBox(height: 22),

            AuthPrimaryButton(
              text: 'تغيير كلمة المرور',
              icon: Icons.check_rounded,
              onPressed: _resetPassword,
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