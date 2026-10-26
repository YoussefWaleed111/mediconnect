import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/di/dependency_injection.dart';
import 'package:mediconnect/core/routing/routes.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mediconnect/features/onboarding/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:mediconnect/features/splash/presentation/widgets/brand_logo_widget.dart';
import 'package:mediconnect/features/splash/presentation/widgets/medical_network_mesh_painter.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _logoFadeAnimation;
  late final Animation<double> _logoScaleAnimation;
  late final Animation<double> _footerFadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _handleInitializationAndNavigation();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoFadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _footerFadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.45, 1.0, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  Future<void> _handleInitializationAndNavigation() async {
    // 1. Check startup state: authentication and onboarding completion
    final authFuture = _verifyAuthenticationState();
    final onboardingFuture = _verifyOnboardingState();
    final delayFuture = Future.delayed(const Duration(milliseconds: 2400));

    // Wait for checks and smooth brand animation duration
    final results = await Future.wait([authFuture, onboardingFuture, delayFuture]);
    final bool isAuthenticated = results[0] as bool;
    final bool isOnboardingCompleted = results[1] as bool;

    if (!mounted) return;

    // 2. Navigate seamlessly based on verification
    if (isAuthenticated) {
      context.go(Routes.home);
    } else if (!isOnboardingCompleted) {
      context.go(Routes.onboarding);
    } else {
      context.go(Routes.login);
    }
  }

  Future<bool> _verifyAuthenticationState() async {
    try {
      final authLocalDataSource = getIt<AuthLocalDataSource>();
      final token = await authLocalDataSource.getToken();
      return token != null && token.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _verifyOnboardingState() async {
    try {
      final getOnboardingCompletedUseCase = getIt<GetOnboardingCompletedUseCase>();
      return await getOnboardingCompletedUseCase();
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 1. Subtle Radial / Linear Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.softBackground, // #F7FAFC
                  AppColors.white,          // #FFFFFF
                ],
              ),
            ),
          ),

          // 2. Decorative Medical Network / Constellation Mesh in Corners
          const Positioned.fill(
            child: CustomPaint(
              painter: MedicalNetworkMeshPainter(),
            ),
          ),

          // 3. Main Content: Centered Brand Block & Anchored Footer
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40.0),

                  // Center Brand Block (Logo + Name + Slogan)
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: const BrandLogoWidget(),
                    ),
                  ),

                  // Bottom Anchored Status & Restrained Loader
                  FadeTransition(
                    opacity: _footerFadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 22.0,
                            height: 22.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14.0),
                          Text(
                            'Connecting you to better care',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 13.5,
                              color: AppColors.textSecondary,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
