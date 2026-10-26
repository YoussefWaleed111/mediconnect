import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';

class MetricStatDto {
  final String title;
  final String counterText;
  final double percentageChange;
  final String periodText;
  final bool isPositive;
  final IconData? icon;

  const MetricStatDto({
    required this.title,
    required this.counterText,
    required this.percentageChange,
    this.periodText = 'this month',
    this.isPositive = true,
    this.icon,
  });

  // Decoupled factory supporting both .NET PascalCase and camelCase JSON
  factory MetricStatDto.fromJson(Map<String, dynamic> json) {
    final change = ((json['percentageChange'] ??
            json['PercentageChange'] ??
            json['change'] ??
            12.0) as num)
        .toDouble();

    return MetricStatDto(
      title:
          (json['title'] ?? json['Title'] ?? 'Total Patients').toString(),
      counterText: (json['counterText'] ??
              json['CounterText'] ??
              json['total'] ??
              '14,240')
          .toString(),
      percentageChange: change,
      periodText: (json['periodText'] ??
              json['PeriodText'] ??
              'this month')
          .toString(),
      isPositive: (json['isPositive'] ?? json['IsPositive'] ?? (change >= 0))
          as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'counterText': counterText,
        'percentageChange': percentageChange,
        'periodText': periodText,
        'isPositive': isPositive,
      };
}

class StatCard extends StatelessWidget {
  final MetricStatDto stat;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.stat,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color badgeBg =
        stat.isPositive ? AppColors.successLight : AppColors.errorLight;
    final Color badgeText =
        stat.isPositive ? AppColors.success : AppColors.errorRed;
    final IconData trendIcon = stat.isPositive
        ? Icons.trending_up_rounded
        : Icons.trending_down_rounded;

    final String sign = stat.isPositive ? '+' : '';
    final String formattedPercentage =
        '$sign${stat.percentageChange.toStringAsFixed(stat.percentageChange.truncateToDouble() == stat.percentageChange ? 0 : 1)}%';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.border, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepNavy.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title & Optional Top Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    stat.title,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (stat.icon != null)
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: AppColors.softTealBg,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      stat.icon,
                      color: AppColors.primary,
                      size: 18.0,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Large Total Counter
            Text(
              stat.counterText,
              style: AppTextStyles.heading1.copyWith(
                fontSize: 28.0,
                fontWeight: FontWeight.w800,
                color: AppColors.darkTextPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12.0),

            // Percentage Change Tag
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    trendIcon,
                    color: badgeText,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '$formattedPercentage ${stat.periodText}',
                    style: AppTextStyles.caption.copyWith(
                      color: badgeText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
