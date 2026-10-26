import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';

class DoctorDto {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String? avatarUrl;
  final String? clinicName;

  const DoctorDto({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    this.avatarUrl,
    this.clinicName,
  });

  // Decoupled factory supporting both .NET PascalCase and camelCase JSON
  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto(
      id: (json['id'] ?? json['Id'] ?? '').toString(),
      name: (json['name'] ?? json['Name'] ?? 'Dr. Sarah Jenkins').toString(),
      specialty:
          (json['specialty'] ?? json['Specialty'] ?? 'Cardiologist').toString(),
      rating: ((json['rating'] ?? json['Rating'] ?? 4.9) as num).toDouble(),
      reviewCount: (json['reviewCount'] ??
          json['ReviewCount'] ??
          json['reviewsCount'] ??
          120) as int,
      avatarUrl: (json['avatarUrl'] ?? json['AvatarUrl']) as String?,
      clinicName: (json['clinicName'] ?? json['ClinicName']) as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'specialty': specialty,
        'rating': rating,
        'reviewCount': reviewCount,
        'avatarUrl': avatarUrl,
        'clinicName': clinicName,
      };
}

class DoctorCard extends StatelessWidget {
  final DoctorDto doctor;
  final VoidCallback? onTap;
  final VoidCallback? onBookTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.border, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepNavy.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                width: 68.0,
                height: 68.0,
                child: doctor.avatarUrl != null && doctor.avatarUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: doctor.avatarUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.softTealBg,
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => _buildAvatarPlaceholder(),
                      )
                    : _buildAvatarPlaceholder(),
              ),
            ),
            const SizedBox(width: 14.0),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: AppTextStyles.subheading.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    doctor.specialty,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.warning,
                        size: 18.0,
                      ),
                      const SizedBox(width: 3.0),
                      Text(
                        doctor.rating.toStringAsFixed(1),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.darkTextPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '(${doctor.reviewCount}+ reviews)',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Optional Book or Arrow Action
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.softTealBg,
      child: Center(
        child: Text(
          doctor.name.isNotEmpty
              ? doctor.name
                  .split(' ')
                  .map((e) => e.isNotEmpty ? e[0] : '')
                  .take(2)
                  .join()
              : 'DR',
          style: AppTextStyles.subheading.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
