import 'package:flutter/material.dart';
import 'package:mediconnect/core/errors/failures.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/widgets/custom_button.dart';

enum ErrorStateType {
  networkFailure,
  dataLoadFailure,
  validationError,
  submissionFailure,
  unauthorized;

  // Cleanly maps .NET Web API HTTP status codes to design error states
  static ErrorStateType fromStatusCode(int? statusCode) {
    if (statusCode == null) return ErrorStateType.dataLoadFailure;
    switch (statusCode) {
      case 401:
      case 403:
        return ErrorStateType.unauthorized;
      case 400:
      case 422:
        return ErrorStateType.validationError;
      case 500:
      case 502:
      case 503:
      case 504:
        return ErrorStateType.submissionFailure;
      default:
        return ErrorStateType.dataLoadFailure;
    }
  }

  // Maps Clean Architecture Failures
  static ErrorStateType fromFailure(Failure failure) {
    if (failure is NetworkFailure) {
      return ErrorStateType.networkFailure;
    }
    if (failure.statusCode != null) {
      return fromStatusCode(failure.statusCode);
    }
    return ErrorStateType.dataLoadFailure;
  }
}

class ErrorStateWidget extends StatelessWidget {
  final ErrorStateType type;
  final String? customTitle;
  final String? customMessage;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final String? primaryActionText;
  final String? secondaryActionText;
  final List<String>? validationErrors;
  final bool isCard;

  const ErrorStateWidget({
    super.key,
    required this.type,
    this.customTitle,
    this.customMessage,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.primaryActionText,
    this.secondaryActionText,
    this.validationErrors,
    this.isCard = false,
  });

  // State 1: Network Connection Failure
  factory ErrorStateWidget.network({
    Key? key,
    VoidCallback? onRetry,
    bool isCard = false,
  }) {
    return ErrorStateWidget(
      key: key,
      type: ErrorStateType.networkFailure,
      customTitle: 'No Internet Connection',
      customMessage:
          'Please check your Wi-Fi or cellular data connection and try again.',
      primaryActionText: 'Retry Connection',
      onPrimaryAction: onRetry,
      isCard: isCard,
    );
  }

  // State 2: Failed Data Loading
  factory ErrorStateWidget.dataLoading({
    Key? key,
    VoidCallback? onRetry,
    String? message,
    bool isCard = false,
  }) {
    return ErrorStateWidget(
      key: key,
      type: ErrorStateType.dataLoadFailure,
      customTitle: 'Unable to Load Records',
      customMessage: message ??
          'We encountered an issue while retrieving your health records. Please try again.',
      primaryActionText: 'Retry Loading',
      onPrimaryAction: onRetry,
      isCard: isCard,
    );
  }

  // State 3: Form Validation Error
  factory ErrorStateWidget.validation({
    Key? key,
    VoidCallback? onEdit,
    String? message,
    List<String>? validationErrors,
    bool isCard = false,
  }) {
    return ErrorStateWidget(
      key: key,
      type: ErrorStateType.validationError,
      customTitle: 'Required Fields Missing',
      customMessage: message ??
          'Please review the highlighted fields in the form and provide all required information.',
      primaryActionText: 'Edit Information',
      onPrimaryAction: onEdit,
      validationErrors: validationErrors,
      isCard: isCard,
    );
  }

  // State 4: Submission Failure (Dual Actions: Edit Details + Retry Submission)
  factory ErrorStateWidget.submission({
    Key? key,
    VoidCallback? onRetry,
    VoidCallback? onEdit,
    String? message,
    bool isCard = false,
  }) {
    return ErrorStateWidget(
      key: key,
      type: ErrorStateType.submissionFailure,
      customTitle: 'Submission Failed',
      customMessage: message ??
          'We couldn\'t process your request on the server. Please verify your details or try again.',
      primaryActionText: 'Retry Submission',
      onPrimaryAction: onRetry,
      secondaryActionText: 'Edit Details',
      onSecondaryAction: onEdit,
      isCard: isCard,
    );
  }

  // State 5: Permission Denied / Unauthorized
  factory ErrorStateWidget.unauthorized({
    Key? key,
    VoidCallback? onGoHome,
    String? message,
    bool isCard = false,
  }) {
    return ErrorStateWidget(
      key: key,
      type: ErrorStateType.unauthorized,
      customTitle: 'Access Denied',
      customMessage: message ??
          'You do not have authorization to view this medical record. Please contact your clinic administrator.',
      primaryActionText: 'Go Back Home',
      onPrimaryAction: onGoHome,
      isCard: isCard,
    );
  }

  // Automatic Factory from Clean Architecture Failure
  factory ErrorStateWidget.fromFailure(
    Failure failure, {
    Key? key,
    VoidCallback? onRetry,
    VoidCallback? onSecondary,
    bool isCard = false,
  }) {
    final mappedType = ErrorStateType.fromFailure(failure);
    switch (mappedType) {
      case ErrorStateType.networkFailure:
        return ErrorStateWidget.network(
          key: key,
          onRetry: onRetry,
          isCard: isCard,
        );
      case ErrorStateType.unauthorized:
        return ErrorStateWidget.unauthorized(
          key: key,
          onGoHome: onRetry,
          message: failure.message,
          isCard: isCard,
        );
      case ErrorStateType.validationError:
        return ErrorStateWidget.validation(
          key: key,
          onEdit: onRetry,
          message: failure.message,
          isCard: isCard,
        );
      case ErrorStateType.submissionFailure:
        return ErrorStateWidget.submission(
          key: key,
          onRetry: onRetry,
          onEdit: onSecondary,
          message: failure.message,
          isCard: isCard,
        );
      case ErrorStateType.dataLoadFailure:
        return ErrorStateWidget.dataLoading(
          key: key,
          onRetry: onRetry,
          message: failure.message,
          isCard: isCard,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);

    if (isCard) {
      return Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepNavy.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: content,
      );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
        child: content,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final visual = _getVisuals();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Badge
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: visual.bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            visual.icon,
            color: visual.iconColor,
            size: 38.0,
          ),
        ),
        const SizedBox(height: 24.0),

        // Title
        Text(
          customTitle ?? visual.defaultTitle,
          style: AppTextStyles.heading1.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: AppColors.darkTextPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),

        // Message
        Text(
          customMessage ?? visual.defaultMessage,
          style: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),

        // Validation Errors Bullet List (if applicable)
        if (validationErrors != null && validationErrors!.isNotEmpty) ...[
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColors.errorRed.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: validationErrors!
                  .map(
                    (err) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 6.0,
                            color: AppColors.errorRed,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              err,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.errorRed,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        const SizedBox(height: 28.0),

        // Actions
        if (type == ErrorStateType.submissionFailure &&
            secondaryActionText != null &&
            onSecondaryAction != null)
          Row(
            children: [
              Expanded(
                child: CustomButton.outlined(
                  text: secondaryActionText!,
                  height: 48.0,
                  onPressed: onSecondaryAction,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: CustomButton.primary(
                  text: primaryActionText ?? 'Retry',
                  height: 48.0,
                  onPressed: onPrimaryAction,
                ),
              ),
            ],
          )
        else if (primaryActionText != null && onPrimaryAction != null)
          CustomButton.primary(
            text: primaryActionText!,
            height: 48.0,
            width: 220.0,
            onPressed: onPrimaryAction,
          ),
      ],
    );
  }

  _ErrorVisuals _getVisuals() {
    switch (type) {
      case ErrorStateType.networkFailure:
        return _ErrorVisuals(
          icon: Icons.wifi_off_rounded,
          iconColor: AppColors.warning,
          bgColor: AppColors.warningLight,
          defaultTitle: 'No Internet Connection',
          defaultMessage:
              'Please check your network settings and try reconnecting.',
        );
      case ErrorStateType.dataLoadFailure:
        return _ErrorVisuals(
          icon: Icons.cloud_off_rounded,
          iconColor: AppColors.errorRed,
          bgColor: AppColors.errorLight,
          defaultTitle: 'Unable to Load Records',
          defaultMessage:
              'We were unable to load the requested information. Please try again.',
        );
      case ErrorStateType.validationError:
        return _ErrorVisuals(
          icon: Icons.error_outline_rounded,
          iconColor: AppColors.warning,
          bgColor: AppColors.warningLight,
          defaultTitle: 'Required Fields Missing',
          defaultMessage:
              'Please correct the indicated errors to proceed.',
        );
      case ErrorStateType.submissionFailure:
        return _ErrorVisuals(
          icon: Icons.report_problem_rounded,
          iconColor: AppColors.errorRed,
          bgColor: AppColors.errorLight,
          defaultTitle: 'Submission Failed',
          defaultMessage:
              'An error occurred while transmitting your request to the server.',
        );
      case ErrorStateType.unauthorized:
        return _ErrorVisuals(
          icon: Icons.lock_outline_rounded,
          iconColor: AppColors.deepNavy,
          bgColor: AppColors.softNeutralBg,
          defaultTitle: 'Access Denied',
          defaultMessage:
              'You do not possess the required privileges to view this section.',
        );
    }
  }
}

class _ErrorVisuals {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String defaultTitle;
  final String defaultMessage;

  _ErrorVisuals({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.defaultTitle,
    required this.defaultMessage,
  });
}
