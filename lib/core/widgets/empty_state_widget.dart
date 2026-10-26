import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/widgets/custom_button.dart';

class EmptyStateWidget extends StatelessWidget {
  final Widget? iconWidget;
  final IconData? iconData;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final ButtonVariant buttonVariant;
  final Widget? customAction;
  final double iconSize;

  const EmptyStateWidget({
    super.key,
    this.iconWidget,
    this.iconData,
    this.iconColor,
    this.iconBackgroundColor,
    required this.title,
    required this.description,
    this.actionText,
    this.onActionPressed,
    this.buttonVariant = ButtonVariant.primary,
    this.customAction,
    this.iconSize = 40.0,
  });

  // Preset 1: No Upcoming Appointments
  factory EmptyStateWidget.noAppointments({
    Key? key,
    VoidCallback? onBook,
  }) {
    return EmptyStateWidget(
      key: key,
      iconData: Icons.event_busy_rounded,
      iconColor: AppColors.primary,
      iconBackgroundColor: AppColors.softTealBg,
      title: 'No Upcoming Appointments',
      description: 'You have no scheduled appointments at this time.',
      actionText: '+ Book New Appointment',
      onActionPressed: onBook,
      buttonVariant: ButtonVariant.primary,
    );
  }

  // Preset 2: No Medical Records
  factory EmptyStateWidget.noMedicalRecords({
    Key? key,
    VoidCallback? onRequest,
  }) {
    return EmptyStateWidget(
      key: key,
      iconData: Icons.folder_off_rounded,
      iconColor: AppColors.deepNavy,
      iconBackgroundColor: AppColors.softNeutralBg,
      title: 'No Medical Records',
      description:
          'Your healthcare provider has not shared any records yet. They will appear here when available.',
      actionText: 'Request Records',
      onActionPressed: onRequest,
      buttonVariant: ButtonVariant.outlined,
    );
  }

  // Preset 3: No Search Results
  factory EmptyStateWidget.noSearchResults({
    Key? key,
    VoidCallback? onClear,
  }) {
    return EmptyStateWidget(
      key: key,
      iconData: Icons.search_off_rounded,
      iconColor: AppColors.textSecondary,
      iconBackgroundColor: AppColors.softNeutralBg,
      title: 'No Search Results',
      description:
          'We couldn\'t find any matches for your search. Try adjusting your filters or search terms.',
      actionText: 'Clear Search & Try Again',
      onActionPressed: onClear,
      buttonVariant: ButtonVariant.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular Icon Badge
            Container(
              width: 88.0,
              height: 88.0,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppColors.softTealBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: iconWidget ??
                    Icon(
                      iconData ?? Icons.inbox_rounded,
                      color: iconColor ?? AppColors.primary,
                      size: iconSize,
                    ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Title
            Text(
              title,
              style: AppTextStyles.heading1.copyWith(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: AppColors.darkTextPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),

            // Description
            Text(
              description,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            // Action Button
            if (customAction != null) ...[
              const SizedBox(height: 28.0),
              customAction!,
            ] else if (actionText != null && onActionPressed != null) ...[
              const SizedBox(height: 28.0),
              CustomButton(
                text: actionText!,
                variant: buttonVariant,
                height: 48.0,
                width: 220.0,
                onPressed: onActionPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
