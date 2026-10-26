import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/features/onboarding/domain/models/onboarding_item.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPageItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Responsive & Flexible Illustration Asset
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Image.asset(
                item.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // 2. Main Title (Deep Navy)
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.font24Bold.copyWith(
              color: AppColors.deepNavy,
              fontSize: 28.0,
              fontWeight: FontWeight.w800,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12.0),

          // 3. Subtitle (Secondary Gray)
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
              fontSize: 15.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
