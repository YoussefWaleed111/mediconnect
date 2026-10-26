import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/di/dependency_injection.dart';
import 'package:mediconnect/core/routing/routes.dart';
import 'package:mediconnect/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mediconnect/features/auth/presentation/views/login_view.dart';
import 'package:mediconnect/features/home/presentation/views/home_view.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
