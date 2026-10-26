import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/routing/routes.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/widgets/custom_button.dart';
import 'package:mediconnect/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:mediconnect/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:mediconnect/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:mediconnect/features/onboarding/presentation/widgets/onboarding_page_item.dart';
import 'package:mediconnect/features/splash/presentation/widgets/medical_network_mesh_painter.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed(BuildContext context, OnboardingState state) {
    if (state.isLastPage) {
      _completeAndNavigate(context);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _completeAndNavigate(BuildContext context) async {
    await context.read<OnboardingCubit>().completeOnboarding();
    if (context.mounted) {
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 1. Soft Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.softBackground,
                  AppColors.white,
                ],
              ),
            ),
          ),

          // 2. Faint Medical Network / Constellation Mesh Decoration
          const Positioned.fill(
            child: CustomPaint(
              painter: MedicalNetworkMeshPainter(),
            ),
          ),

          // 3. Main Onboarding Content Flow
          SafeArea(
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                final bool isLastPage = state.isLastPage;

                return Column(
                  children: [
                    // Top App Bar Area: Skip Action Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AnimatedOpacity(
                          opacity: isLastPage ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: IgnorePointer(
                            ignoring: isLastPage,
                            child: TextButton(
                              onPressed: () => _completeAndNavigate(context),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.textSecondary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                              ),
                              child: Text(
                                'Skip',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Central Swipeable PageView Area
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.items.length,
                        onPageChanged: (index) {
                          context.read<OnboardingCubit>().onPageChanged(index);
                        },
                        itemBuilder: (context, index) {
                          return OnboardingPageItem(item: state.items[index]);
                        },
                      ),
                    ),

                    // Bottom Persistent Navigation Block
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 28.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animated Indicator Dots
                          OnboardingPageIndicator(
                            count: state.items.length,
                            currentIndex: state.currentIndex,
                          ),
                          const SizedBox(height: 28.0),

                          // Primary Action Button ("Next" / "Get Started")
                          CustomButton.primary(
                            text: isLastPage ? 'Get Started' : 'Next',
                            height: 52.0,
                            onPressed: () => _onNextPressed(context, state),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
