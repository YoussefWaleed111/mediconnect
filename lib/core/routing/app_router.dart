import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/di/dependency_injection.dart';
import 'package:mediconnect/core/routing/routes.dart';
import 'package:mediconnect/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mediconnect/features/auth/presentation/views/login_view.dart';
import 'package:mediconnect/features/home/presentation/views/home_view.dart';
import 'package:mediconnect/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:mediconnect/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:mediconnect/features/splash/presentation/views/splash_view.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      // 1. Splash Screen
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),

      // 2. Onboarding Screen
      GoRoute(
        path: Routes.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => getIt<OnboardingCubit>(),
            child: const OnboardingView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // 2. Authentication Login Screen
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: const LoginView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // 3. Main Home Screen
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
    ],
  );
}
