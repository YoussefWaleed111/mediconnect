import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/utils/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Icon(
            Icons.local_hospital_rounded,
            color: AppColors.primaryColor,
            size: 30.0,
          ),
        ),
        const SizedBox(height: 24.0),
        Text(
          AppStrings.welcomeBack,
          style: AppTextStyles.font24Bold,
        ),
        const SizedBox(height: 8.0),
        Text(
          AppStrings.loginSubtitle,
          style: AppTextStyles.font14Regular,
        ),
      ],
    );
  }
}
