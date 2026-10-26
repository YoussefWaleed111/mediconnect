import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/routing/routes.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MediConnect Home',
          style: AppTextStyles.font18Semibold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            onPressed: () {
              context.go(Routes.login);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColors.primaryColor,
                  size: 48.0,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Clean Architecture Initialized!',
                textAlign: TextAlign.center,
                style: AppTextStyles.font24Bold,
              ),
              const SizedBox(height: 12.0),
              Text(
                'Production-ready Clean Architecture, Domain-Driven Design, and GoRouter setup are ready.',
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular,
              ),
              const SizedBox(height: 36.0),
              CustomButton(
                text: 'Back to Login',
                onPressed: () {
                  context.go(Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
