import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/widgets/skeletons/shimmer_container.dart';

class AppointmentListSkeleton extends StatelessWidget {
  final int itemCount;

  const AppointmentListSkeleton({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Tab Bar Header Placeholder
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: AppColors.softNeutralBg,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: const [
                Expanded(
                  child: ShimmerContainer(height: 36, borderRadius: 8),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: ShimmerContainer(height: 36, borderRadius: 8),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: ShimmerContainer(height: 36, borderRadius: 8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // 2. Appointment Cards
          ...List.generate(
            itemCount,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildAppointmentCardPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCardPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Header Date/Time & Status Chip Placeholder
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: AppColors.softTealBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerContainer(width: 150, height: 16, borderRadius: 4),
                ShimmerContainer(width: 65, height: 22, borderRadius: 12),
              ],
            ),
          ),
          // Doctor Details & Action Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const ShimmerContainer(width: 52, height: 52, borderRadius: 12),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          ShimmerContainer(width: 130, height: 16, borderRadius: 4),
                          SizedBox(height: 6),
                          ShimmerContainer(width: 170, height: 13, borderRadius: 4),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: ShimmerContainer(height: 40, borderRadius: 10),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ShimmerContainer(height: 40, borderRadius: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
