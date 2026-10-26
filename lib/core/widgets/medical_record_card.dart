import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';

enum RecordCategory {
  labResult,
  prescription,
  radiology,
  vaccination,
  generalReport;

  static RecordCategory fromJson(dynamic json) {
    if (json == null) return RecordCategory.generalReport;
    final str = json.toString().toLowerCase().trim();
    switch (str) {
      case 'labresult':
      case 'lab':
      case '0':
        return RecordCategory.labResult;
      case 'prescription':
      case '1':
        return RecordCategory.prescription;
      case 'radiology':
      case 'xray':
      case '2':
        return RecordCategory.radiology;
      case 'vaccination':
      case 'vaccine':
      case '3':
        return RecordCategory.vaccination;
      default:
        return RecordCategory.generalReport;
    }
  }

  IconData get icon {
    switch (this) {
      case RecordCategory.labResult:
        return Icons.biotech_rounded;
      case RecordCategory.prescription:
        return Icons.medication_rounded;
      case RecordCategory.radiology:
        return Icons.document_scanner_rounded;
      case RecordCategory.vaccination:
        return Icons.vaccines_rounded;
      case RecordCategory.generalReport:
        return Icons.description_rounded;
    }
  }

  Color get iconColor {
    switch (this) {
      case RecordCategory.labResult:
        return AppColors.primary;
      case RecordCategory.prescription:
        return AppColors.secondary;
      case RecordCategory.radiology:
        return AppColors.deepNavy;
      case RecordCategory.vaccination:
        return AppColors.success;
      case RecordCategory.generalReport:
        return AppColors.warning;
    }
  }

  Color get bgColor {
    switch (this) {
      case RecordCategory.labResult:
        return AppColors.softTealBg;
      case RecordCategory.prescription:
        return AppColors.softTealBg;
      case RecordCategory.radiology:
        return AppColors.softNeutralBg;
      case RecordCategory.vaccination:
        return AppColors.successLight;
      case RecordCategory.generalReport:
        return AppColors.warningLight;
    }
  }
}

class MedicalRecordDto {
  final String id;
  final String title;
  final String recordType;
  final String dateText;
  final String? doctorOrFacility;
  final String? fileSize;
  final RecordCategory category;

  const MedicalRecordDto({
    required this.id,
    required this.title,
    required this.recordType,
    required this.dateText,
    this.doctorOrFacility,
    this.fileSize,
    this.category = RecordCategory.generalReport,
  });

  // Decoupled factory supporting both .NET PascalCase and camelCase JSON
  factory MedicalRecordDto.fromJson(Map<String, dynamic> json) {
    return MedicalRecordDto(
      id: (json['id'] ?? json['Id'] ?? '').toString(),
      title: (json['title'] ??
              json['Title'] ??
              'Complete Blood Count (CBC)')
          .toString(),
      recordType: (json['recordType'] ??
              json['RecordType'] ??
              'Laboratory Test')
          .toString(),
      dateText: (json['dateText'] ??
              json['DateText'] ??
              json['date'] ??
              '15 Oct 2026')
          .toString(),
      doctorOrFacility: (json['doctorOrFacility'] ??
              json['DoctorOrFacility'] ??
              'City General Hospital')
          as String?,
      fileSize: (json['fileSize'] ?? json['FileSize'] ?? '2.4 MB') as String?,
      category: RecordCategory.fromJson(json['category'] ?? json['Category']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'recordType': recordType,
        'dateText': dateText,
        'doctorOrFacility': doctorOrFacility,
        'fileSize': fileSize,
        'category': category.name,
      };
}

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecordDto record;
  final VoidCallback? onTap;

  const MedicalRecordCard({
    super.key,
    required this.record,
    this.onTap,
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
              color: AppColors.deepNavy.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Badge
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: record.category.bgColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                record.category.icon,
                color: record.category.iconColor,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 14.0),

            // Record Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkTextPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    '${record.recordType} • ${record.dateText}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (record.doctorOrFacility != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      record.doctorOrFacility!,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Navigation Arrow
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
}
