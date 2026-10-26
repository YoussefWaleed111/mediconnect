import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';
import 'package:mediconnect/core/widgets/custom_button.dart';
import 'package:mediconnect/core/widgets/doctor_card.dart';
import 'package:mediconnect/core/widgets/status_chip.dart';

class UpcomingAppointmentDto {
  final String id;
  final DoctorDto doctor;
  final String dateText;
  final String timeText;
  final AppointmentStatus status;
  final String consultationType;

  const UpcomingAppointmentDto({
    required this.id,
    required this.doctor,
    required this.dateText,
    required this.timeText,
    this.status = AppointmentStatus.confirmed,
    this.consultationType = 'Video Call',
  });

  // Decoupled factory supporting both .NET PascalCase and camelCase JSON
  factory UpcomingAppointmentDto.fromJson(Map<String, dynamic> json) {
    return UpcomingAppointmentDto(
      id: (json['id'] ?? json['Id'] ?? '').toString(),
      doctor: DoctorDto.fromJson(
        (json['doctor'] ?? json['Doctor'] ?? <String, dynamic>{})
            as Map<String, dynamic>,
      ),
      dateText: (json['dateText'] ??
              json['DateText'] ??
              json['date'] ??
              'Today, 24 Oct')
          .toString(),
      timeText: (json['timeText'] ??
              json['TimeText'] ??
              json['time'] ??
              '10:30 AM - 11:00 AM')
          .toString(),
      status: AppointmentStatus.fromJson(json['status'] ?? json['Status']),
      consultationType: (json['consultationType'] ??
              json['ConsultationType'] ??
              'Video Call')
          .toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'doctor': doctor.toJson(),
        'dateText': dateText,
        'timeText': timeText,
        'status': status.name,
        'consultationType': consultationType,
      };
}

class UpcomingAppointmentCard extends StatelessWidget {
  final UpcomingAppointmentDto appointment;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final String primaryActionText;
  final String secondaryActionText;

  const UpcomingAppointmentCard({
    super.key,
    required this.appointment,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.primaryActionText = 'Join Call',
    this.secondaryActionText = 'Reschedule',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Date/Time Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: AppColors.softTealBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primary,
                  size: 18.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '${appointment.dateText} • ${appointment.timeText}',
                    style: AppTextStyles.captionMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatusChip(status: appointment.status),
              ],
            ),
          ),

          // 2. Doctor Info Body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: SizedBox(
                        width: 52.0,
                        height: 52.0,
                        child: appointment.doctor.avatarUrl != null &&
                                appointment.doctor.avatarUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: appointment.doctor.avatarUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) =>
                                    _buildDoctorFallbackAvatar(),
                              )
                            : _buildDoctorFallbackAvatar(),
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.doctor.name,
                            style: AppTextStyles.subheading.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            '${appointment.doctor.specialty} • ${appointment.consultationType}',
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // 3. Dual Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: secondaryActionText,
                        variant: ButtonVariant.outlined,
                        height: 42.0,
                        textStyle: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        onPressed: onSecondaryAction,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: CustomButton(
                        text: primaryActionText,
                        variant: ButtonVariant.primary,
                        height: 42.0,
                        textStyle: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        prefixIcon: const Icon(
                          Icons.videocam_rounded,
                          color: AppColors.white,
                          size: 18.0,
                        ),
                        onPressed: onPrimaryAction,
                      ),
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

  Widget _buildDoctorFallbackAvatar() {
    return Container(
      color: AppColors.softNeutralBg,
      child: const Center(
        child: Icon(
          Icons.person_rounded,
          color: AppColors.primary,
          size: 28.0,
        ),
      ),
    );
  }
}
