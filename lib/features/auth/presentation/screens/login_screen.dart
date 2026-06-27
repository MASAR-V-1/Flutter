import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_responsive_layout.dart';
import 'forgot_password_screen.dart';
import 'package:masar_app/features/manager/presentation/screens/manager_home_screen.dart';

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

    context.go(ManagerHomeScreen.routePath);
  }

    // Later:
    // context.read<LoginCubit>().login(...)
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('سيتم ربط تسجيل الدخول مع API لاحقًا'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AuthResponsiveLayout(
      title: 'الدخول إلى مساحة العمل',
      subtitle: 'أدخل بيانات حسابك للوصول إلى مساحة عمل مؤسستك.',
      sideTitle: 'مساحة تشغيل ذكية للمؤسسات',
      sideSubtitle:
      'ادخل إلى مساحة عمل مؤسستك وتابع الفرق، الوحدات، المهام، والتقارير من مكان واحد.',
      sideItems: const [
        'صلاحيات محمية',
        'وحدات مفعّلة',
        'تقارير ومتابعة',
        'مساحة عمل آمنة',
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تسجيل الدخول',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'مرحبًا بك مجددًا، أدخل بياناتك للمتابعة.',
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
            const SizedBox(height: 18),

            AuthTextField(
              label: 'كلمة المرور',
              hintText: 'أدخل كلمة المرور',
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
                  'تذكرني',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.push(ForgotPasswordScreen.routePath);
                  },
                  child: const Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            AuthPrimaryButton(
              text: 'تسجيل الدخول',
              icon: Icons.arrow_back,
              onPressed: _submit,
            ),

            const SizedBox(height: 24),

            const Divider(color: Color(0xFFE5E7EB)),

            const SizedBox(height: 18),

            // Center(
            //   child: Wrap(
            //     alignment: WrapAlignment.center,
            //     crossAxisAlignment: WrapCrossAlignment.center,
            //     children: [
            //       const Text(
            //         'ليس لديك حساب؟ ',
            //         style: TextStyle(
            //           color: Color(0xFF6B7280),
            //           fontSize: 14,
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {
            //           context.go('/register');
            //         },
            //         child: const Text(
            //           'إنشاء حساب مؤسسة',
            //           style: TextStyle(
            //             color: Color(0xFF0B5F4B),
            //             fontWeight: FontWeight.w800,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 12),

            const AuthInfoBox(
              text:
              'يتم منح صلاحيات الدخول وإدارة الحسابات من خلال مدير المؤسسة بعد قبول ملف المؤسسة.',
            ),
          ],
        ),
      ),
    );
  }
}