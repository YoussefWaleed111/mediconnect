import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/utils/app_assets.dart';

class BrandLogoWidget extends StatelessWidget {
  final double width;
  final double? height;
  final bool showText;
  final bool showSlogan;

  const BrandLogoWidget({
    super.key,
    this.width = 180.0,
    this.height,
    this.showText = true,
    this.showSlogan = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. MediConnect Official Brand Logo Asset
        Image.asset(
          AppAssets.logo,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
        if (showText) ...[
          const SizedBox(height: 16.0),
          // 2. Brand Name 'MediConnect'
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Medi',
                  style: AppTextStyles.displayBig.copyWith(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepNavy,
                    letterSpacing: -0.6,
                  ),
                ),
                TextSpan(
                  text: 'Connect',
                  style: AppTextStyles.displayBig.copyWith(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -0.6,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (showSlogan) ...[
          const SizedBox(height: 8.0),
          // 3. Primary Slogan
          Text(
            'Your Health, Connected.',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

