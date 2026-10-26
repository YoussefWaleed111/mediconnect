import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final ShapeBorder? shapeBorder;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;

  const ShimmerContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.shapeBorder,
    this.shape = BoxShape.rectangle,
    this.margin,
  });

  const ShimmerContainer.circular({
    Key? key,
    required double size,
    EdgeInsetsGeometry? margin,
  }) : this(
          key: key,
          width: size,
          height: size,
          shape: BoxShape.circle,
          margin: margin,
        );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.softNeutralBg,
      highlightColor: AppColors.softBackground,
      period: const Duration(milliseconds: 1400),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: shapeBorder != null
            ? ShapeDecoration(
                color: AppColors.softNeutralBg,
                shape: shapeBorder!,
              )
            : BoxDecoration(
                color: AppColors.softNeutralBg,
                shape: shape,
                borderRadius: shape == BoxShape.circle
                    ? null
                    : BorderRadius.circular(borderRadius),
              ),
      ),
    );
  }
}
