import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/widgets/skeletons/shimmer_container.dart';

class DoctorSearchSkeleton extends StatelessWidget {
  final int itemCount;

  const DoctorSearchSkeleton({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Search Bar Placeholder
          const ShimmerContainer(
            height: 52.0,
            borderRadius: 12.0,
          ),
          const SizedBox(height: 16.0),

          // 2. Filter Chips Row Placeholder
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(
                5,
                (index) => const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ShimmerContainer(
                    width: 80.0,
                    height: 34.0,
                    borderRadius: 20.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // 3. Search Result Header Placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerContainer(width: 120, height: 18, borderRadius: 4),
              ShimmerContainer(width: 50, height: 14, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 14.0),

          // 4. List of Doctor Profile Card Placeholders
          ...List.generate(
            itemCount,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildDoctorCardPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCardPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const ShimmerContainer(
            width: 68.0,
            height: 68.0,
            borderRadius: 12.0,
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerContainer(width: 150, height: 16, borderRadius: 4),
                SizedBox(height: 6),
                ShimmerContainer(width: 100, height: 13, borderRadius: 4),
                SizedBox(height: 8),
                ShimmerContainer(width: 120, height: 14, borderRadius: 4),
              ],
            ),
          ),
          const ShimmerContainer(
            width: 20.0,
            height: 20.0,
            borderRadius: 4.0,
          ),
        ],
      ),
    );
  }
}
