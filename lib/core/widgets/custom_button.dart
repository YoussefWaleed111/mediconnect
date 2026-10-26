import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';

enum ButtonVariant {
  primary,
  secondary,
  outlined,
  destructive,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonVariant variant;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
    this.width,
    this.height = 50.0,
    this.borderRadius = 12.0,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textStyle,
  });

  // Convenience Factory Constructors
  factory CustomButton.primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    double? width,
    double height = 50.0,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) =>
      CustomButton(
        key: key,
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        variant: ButtonVariant.primary,
        width: width,
        height: height,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );

  factory CustomButton.secondary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    double? width,
    double height = 50.0,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) =>
      CustomButton(
        key: key,
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        variant: ButtonVariant.secondary,
        width: width,
        height: height,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );

  factory CustomButton.outlined({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    double? width,
    double height = 50.0,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) =>
      CustomButton(
        key: key,
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        variant: ButtonVariant.outlined,
        width: width,
        height: height,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );

  factory CustomButton.destructive({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    double? width,
    double height = 50.0,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) =>
      CustomButton(
        key: key,
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        variant: ButtonVariant.destructive,
        width: width,
        height: height,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    // Resolve Colors & Styling according to Variant
    Color resolvedBgColor;
    Color resolvedTextColor;
    BorderSide resolvedBorder;

    switch (variant) {
      case ButtonVariant.primary:
        resolvedBgColor = backgroundColor ?? AppColors.primary;
        resolvedTextColor = AppColors.white;
        resolvedBorder = BorderSide.none;
        break;
      case ButtonVariant.secondary:
        resolvedBgColor = backgroundColor ?? AppColors.softTealBg;
        resolvedTextColor = AppColors.primary;
        resolvedBorder = BorderSide.none;
        break;
      case ButtonVariant.outlined:
        resolvedBgColor = backgroundColor ?? AppColors.transparent;
        resolvedTextColor = AppColors.primary;
        resolvedBorder = const BorderSide(color: AppColors.border, width: 1.5);
        break;
      case ButtonVariant.destructive:
        resolvedBgColor = backgroundColor ?? AppColors.errorRed;
        resolvedTextColor = AppColors.white;
        resolvedBorder = BorderSide.none;
        break;
    }

    if (isDisabled) {
      if (variant == ButtonVariant.outlined) {
        resolvedBorder = BorderSide(color: AppColors.border.withValues(alpha: 0.5));
        resolvedTextColor = AppColors.textTertiary;
      } else {
        resolvedBgColor = resolvedBgColor.withValues(alpha: 0.5);
        resolvedTextColor = resolvedTextColor.withValues(alpha: 0.7);
      }
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBgColor,
          disabledBackgroundColor: resolvedBgColor,
          foregroundColor: resolvedTextColor,
          disabledForegroundColor: resolvedTextColor,
          elevation: 0,
          shadowColor: AppColors.transparent,
          side: resolvedBorder,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.0,
                height: 22.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(resolvedTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8.0),
                  ],
                  Text(
                    text,
                    style: (textStyle ?? AppTextStyles.buttonText).copyWith(
                      color: resolvedTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8.0),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
