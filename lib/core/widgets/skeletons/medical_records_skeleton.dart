import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/widgets/skeletons/shimmer_container.dart';

class MedicalRecordsSkeleton extends StatelessWidget {
  final int itemCount;

  const MedicalRecordsSkeleton({
    super.key,
    this.itemCount = 6,
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

          // 2. Category Filters Placeholder
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(
                4,
                (index) => const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ShimmerContainer(
                    width: 90.0,
                    height: 32.0,
                    borderRadius: 16.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // 3. Section Header Placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerContainer(width: 130, height: 18, borderRadius: 4),
              ShimmerContainer(width: 45, height: 14, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 14.0),

          // 4. List of Medical Record Document Tiles
          ...List.generate(
            itemCount,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildRecordTilePlaceholder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordTilePlaceholder() {
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
            width: 48.0,
            height: 48.0,
            borderRadius: 12.0,
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerContainer(width: 170, height: 16, borderRadius: 4),
                SizedBox(height: 6),
                ShimmerContainer(width: 110, height: 13, borderRadius: 4),
                SizedBox(height: 4),
                ShimmerContainer(width: 80, height: 12, borderRadius: 4),
              ],
            ),
          ),
          const ShimmerContainer(
            width: 18.0,
            height: 18.0,
            borderRadius: 4.0,
          ),
        ],
      ),
    );
  }
}
