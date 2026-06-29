import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import 'package:masar_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:masar_app/features/manager/presentation/screens/manager_shell_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import '../../features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import '../../features/auth/presentation/cubit/logout/logout_cubit.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: SplashScreen.routePath,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: SplashScreen.routePath,
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: LoginScreen.routePath,
      name: LoginScreen.routeName,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => LoginCubit(context.read<AuthRepository>()),
          child: const LoginScreen(),
        );
      },
    ),

    GoRoute(
      path: ForgotPasswordScreen.routePath,
      name: ForgotPasswordScreen.routeName,
      builder: (context, state) {
        return BlocProvider(
          create: (context) =>
              ForgotPasswordCubit(context.read<AuthRepository>()),
          child: const ForgotPasswordScreen(),
        );
      },
    ),

    GoRoute(
      path: ResetPasswordScreen.routePath,
      name: ResetPasswordScreen.routeName,
      builder: (context, state) {
        return BlocProvider(
          create: (context) =>
              ResetPasswordCubit(context.read<AuthRepository>()),
          child: ResetPasswordScreen(
            email: state.uri.queryParameters['email'],
            token: state.uri.queryParameters['token'],
          ),
        );
      },
    ),

    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) =>
          const _TemporaryScreen(title: 'إنشاء حساب مؤسسة'),
    ),

    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const _TemporaryScreen(title: 'لوحة التحكم'),
    ),

    GoRoute(
      path: OnboardingScreen.routePath,
      name: OnboardingScreen.routeName,
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(
      path: ManagerShellScreen.routePath,
      name: ManagerShellScreen.routeName,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => LogoutCubit(context.read<AuthRepository>()),
          child: const ManagerShellScreen(),
        );
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(
          'Router Error:\n${state.error}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  },
);

class _TemporaryScreen extends StatelessWidget {
  final String title;

  const _TemporaryScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
