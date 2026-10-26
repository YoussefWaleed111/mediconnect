import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/widgets/skeletons/shimmer_container.dart';

class AdminTableSkeleton extends StatelessWidget {
  final int rowCount;

  const AdminTableSkeleton({
    super.key,
    this.rowCount = 7,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Search Header with Action Buttons Placeholder
          Row(
            children: const [
              Expanded(
                child: ShimmerContainer(height: 48.0, borderRadius: 10.0),
              ),
              SizedBox(width: 10.0),
              ShimmerContainer(width: 48.0, height: 48.0, borderRadius: 10.0),
              SizedBox(width: 10.0),
              ShimmerContainer(width: 100.0, height: 48.0, borderRadius: 10.0),
            ],
          ),
          const SizedBox(height: 20.0),

          // 2. Card Table Container Placeholder
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  decoration: const BoxDecoration(
                    color: AppColors.softBackground,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
                  ),
                  child: Row(
                    children: const [
                      ShimmerContainer(width: 20, height: 20, borderRadius: 4),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: ShimmerContainer(width: 80, height: 14, borderRadius: 4),
                      ),
                      Expanded(
                        flex: 2,
                        child: ShimmerContainer(width: 60, height: 14, borderRadius: 4),
                      ),
                      Expanded(
                        flex: 2,
                        child: ShimmerContainer(width: 50, height: 14, borderRadius: 4),
                      ),
                      Expanded(
                        flex: 2,
                        child: ShimmerContainer(width: 50, height: 14, borderRadius: 4),
                      ),
                      ShimmerContainer(width: 24, height: 14, borderRadius: 4),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),

                // Table Rows
                ...List.generate(
                  rowCount,
                  (index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        child: Row(
                          children: const [
                            ShimmerContainer(width: 20, height: 20, borderRadius: 4),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  ShimmerContainer.circular(size: 32),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ShimmerContainer(
                                        width: 90,
                                        height: 14,
                                        borderRadius: 4,
                                      ),
                                      SizedBox(height: 4),
                                      ShimmerContainer(
                                        width: 60,
                                        height: 10,
                                        borderRadius: 3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ShimmerContainer(
                                width: 70,
                                height: 13,
                                borderRadius: 4,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ShimmerContainer(
                                width: 60,
                                height: 22,
                                borderRadius: 10,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ShimmerContainer(
                                width: 75,
                                height: 13,
                                borderRadius: 4,
                              ),
                            ),
                            ShimmerContainer(
                              width: 18,
                              height: 18,
                              borderRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      if (index < rowCount - 1)
                        const Divider(height: 1, color: AppColors.border),
                    ],
                  ),
                ),

                // 3. Pagination Bar Placeholder
                const Divider(height: 1, color: AppColors.border),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ShimmerContainer(width: 110, height: 14, borderRadius: 4),
                      Row(
                        children: const [
                          ShimmerContainer(width: 32, height: 32, borderRadius: 8),
                          SizedBox(width: 6),
                          ShimmerContainer(width: 32, height: 32, borderRadius: 8),
                          SizedBox(width: 6),
                          ShimmerContainer(width: 32, height: 32, borderRadius: 8),
                          SizedBox(width: 6),
                          ShimmerContainer(width: 32, height: 32, borderRadius: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
