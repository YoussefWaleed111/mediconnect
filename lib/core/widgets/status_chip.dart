import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';

enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled;

  // Helper parser for .NET JSON responses (camelCase or PascalCase or integer)
  static AppointmentStatus fromJson(dynamic json) {
    if (json == null) return AppointmentStatus.pending;
    final str = json.toString().toLowerCase().trim();
    switch (str) {
      case 'confirmed':
      case '1':
        return AppointmentStatus.confirmed;
      case 'completed':
      case '2':
        return AppointmentStatus.completed;
      case 'cancelled':
      case 'canceled':
      case '3':
        return AppointmentStatus.cancelled;
      case 'pending':
      case '0':
      default:
        return AppointmentStatus.pending;
    }
  }

  String get displayName {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class StatusChip extends StatelessWidget {
  final AppointmentStatus status;
  final String? customLabel;
  final bool showDot;

  const StatusChip({
    super.key,
    required this.status,
    this.customLabel,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case AppointmentStatus.pending:
        bgColor = AppColors.warningLight;
        textColor = AppColors.warning;
        break;
      case AppointmentStatus.confirmed:
        bgColor = AppColors.softTealBg;
        textColor = AppColors.primary;
        break;
      case AppointmentStatus.completed:
        bgColor = AppColors.successLight;
        textColor = AppColors.success;
        break;
      case AppointmentStatus.cancelled:
        bgColor = AppColors.errorLight;
        textColor = AppColors.errorRed;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: textColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
          ],
          Text(
            customLabel ?? status.displayName,
            style: AppTextStyles.caption.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
