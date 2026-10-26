import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double strokeWidth;
  final Color? color;
  final double size;

  const CustomLoadingIndicator({
    super.key,
    this.strokeWidth = 3.0,
    this.color,
    this.size = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
