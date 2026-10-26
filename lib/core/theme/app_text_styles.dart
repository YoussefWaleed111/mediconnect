import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Font Families
  static const String fontInter = 'Inter';
  static const String fontArabic = 'IBM Plex Sans Arabic';

  // Base font family resolver (defaults to Inter with Arabic fallback)
  static const List<String> fontFallback = [fontArabic, fontInter, 'sans-serif'];

  // ==========================================
  // Typography Scale (MediConnect Design System)
  // ==========================================

  // 1. Display Big (32px Bold) - Onboarding titles, hero headers
  static TextStyle get displayBig => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
        height: 1.25,
        letterSpacing: -0.5,
      );

  // 2. Heading 1 (24px Bold) - Section headers, main page titles
  static TextStyle get heading1 => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
        height: 1.3,
        letterSpacing: -0.3,
      );

  // 3. Heading 2 / Subheading (18px Semibold) - Card headers, sub-sections
  static TextStyle get subheading => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
        height: 1.4,
      );

  // 4. Body Regular (16px & 14px Regular) - Content body text, input fields
  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      );

  static TextStyle get bodyRegular => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      );

  // 5. Caption (12px Regular) - Timestamps, helper text, tags
  static TextStyle get caption => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get captionMedium => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // 6. Button Text (16px Semibold) - Action buttons
  static TextStyle get buttonText => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.25,
      );

  // ==========================================
  // Legacy / Named Aliases for Backward Compatibility
  // ==========================================
  static TextStyle get font32Bold => displayBig;
  static TextStyle get font24Bold => heading1;
  static TextStyle get font18Semibold => subheading;
  static TextStyle get font16Regular => bodyLarge;
  static TextStyle get font16Semibold => buttonText;
  static TextStyle get font14Regular => bodyRegular;
  static TextStyle get font12Regular => caption;
  static TextStyle get font12Medium => const TextStyle(
        fontFamily: fontInter,
        fontFamilyFallback: fontFallback,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.4,
      );
}