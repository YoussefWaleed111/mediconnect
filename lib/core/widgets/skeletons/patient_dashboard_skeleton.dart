import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/widgets/skeletons/shimmer_container.dart';

class PatientDashboardSkeleton extends StatelessWidget {
  const PatientDashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. User Welcome Header Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerContainer(width: 130, height: 16, borderRadius: 4),
                  SizedBox(height: 8),
                  ShimmerContainer(width: 190, height: 24, borderRadius: 6),
                ],
              ),
              ShimmerContainer.circular(size: 48),
            ],
          ),
          const SizedBox(height: 24.0),

          // 2. Stat Cards Row
          Row(
            children: [
              Expanded(
                child: _buildStatCardPlaceholder(),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _buildStatCardPlaceholder(),
              ),
            ],
          ),
          const SizedBox(height: 28.0),

          // 3. Upcoming Appointment Header & Card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerContainer(width: 160, height: 20, borderRadius: 4),
              ShimmerContainer(width: 60, height: 16, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 14.0),
          _buildUpcomingAppointmentCardPlaceholder(),
          const SizedBox(height: 28.0),

          // 4. Quick Actions Grid Header & 4 Action Tiles
          const ShimmerContainer(width: 130, height: 20, borderRadius: 4),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Column(
                children: const [
                  ShimmerContainer(width: 64, height: 64, borderRadius: 16),
                  SizedBox(height: 8),
                  ShimmerContainer(width: 50, height: 12, borderRadius: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCardPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerContainer(width: 80, height: 14, borderRadius: 4),
              ShimmerContainer(width: 28, height: 28, borderRadius: 8),
            ],
          ),
          SizedBox(height: 12),
          ShimmerContainer(width: 65, height: 24, borderRadius: 6),
          SizedBox(height: 10),
          ShimmerContainer(width: 90, height: 16, borderRadius: 6),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointmentCardPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: AppColors.softTealBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerContainer(width: 140, height: 16, borderRadius: 4),
                ShimmerContainer(width: 70, height: 20, borderRadius: 10),
              ],
            ),
          ),
          // Doctor Details & Buttons
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
                          ShimmerContainer(width: 140, height: 16, borderRadius: 4),
                          SizedBox(height: 6),
                          ShimmerContainer(width: 90, height: 13, borderRadius: 4),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: ShimmerContainer(height: 42, borderRadius: 12),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ShimmerContainer(height: 42, borderRadius: 12),
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
