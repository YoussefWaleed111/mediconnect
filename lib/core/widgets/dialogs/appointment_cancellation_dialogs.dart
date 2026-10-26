import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/widgets/custom_button.dart';

// =========================================================================
// 1. Cancellation Confirmation Dialog / Modal
// =========================================================================
Future<bool?> showCancellationConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
  required VoidCallback onKeep,
  String doctorName = 'Dr. Sarah Jenkins',
  String appointmentDate = 'Thursday, 24 Oct',
  String appointmentTime = '10:30 AM',
  String? customPrompt,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: AppColors.cardBackground,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull Handle
              Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(height: 20.0),

              // Alert Badge
              Container(
                width: 64.0,
                height: 64.0,
                decoration: const BoxDecoration(
                  color: AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.event_busy_rounded,
                  color: AppColors.errorRed,
                  size: 32.0,
                ),
              ),
              const SizedBox(height: 18.0),

              // Title
              Text(
                'Cancel Appointment?',
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),

              // Subtitle with Doctor / Date Details
              Text(
                customPrompt ??
                    'Are you sure you want to cancel your appointment with $doctorName on $appointmentDate at $appointmentTime? This action cannot be undone.',
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28.0),

              // Dual Action Buttons: Keep & Confirm Destructive
              Row(
                children: [
                  Expanded(
                    child: CustomButton.outlined(
                      text: 'Keep Appointment',
                      height: 48.0,
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                        onKeep();
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: CustomButton.destructive(
                      text: 'Confirm Cancellation',
                      height: 48.0,
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                        onConfirm();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// =========================================================================
// 2. Cancellation Success Dialog / Modal
// =========================================================================
Future<void> showCancellationSuccessDialog(
  BuildContext context, {
  required VoidCallback onDismiss,
  String? successMessage,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.cardBackground,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(height: 24.0),

              // Success Checkmark Badge
              Container(
                width: 72.0,
                height: 72.0,
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 40.0,
                ),
              ),
              const SizedBox(height: 20.0),

              // Title
              Text(
                'Cancellation Successful',
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),

              // Description
              Text(
                successMessage ??
                    'Your appointment has been cancelled successfully. You will receive an updated email confirmation shortly.',
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28.0),

              // Single Primary Action
              CustomButton.primary(
                text: 'Back to My Appointments',
                height: 48.0,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  onDismiss();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

// =========================================================================
// 3. Cancellation Failure Dialog / Modal
// =========================================================================
Future<void> showCancellationFailureDialog(
  BuildContext context, {
  required VoidCallback onRetry,
  required VoidCallback onEdit,
  String? errorMessage,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.cardBackground,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(height: 24.0),

              // Warning Red Badge
              Container(
                width: 72.0,
                height: 72.0,
                decoration: const BoxDecoration(
                  color: AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.errorRed,
                  size: 40.0,
                ),
              ),
              const SizedBox(height: 20.0),

              // Title
              Text(
                'Cancellation Failed',
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),

              // Description
              Text(
                errorMessage ??
                    'We couldn\'t process your cancellation due to a server connection error. Please verify your details or try again.',
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28.0),

              // Dual Action Buttons: Edit Details & Retry Cancellation
              Row(
                children: [
                  Expanded(
                    child: CustomButton.outlined(
                      text: 'Edit Details',
                      height: 48.0,
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        onEdit();
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: CustomButton.destructive(
                      text: 'Retry Cancellation',
                      height: 48.0,
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        onRetry();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
