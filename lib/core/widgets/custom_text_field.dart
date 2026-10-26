import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_text_styles.dart';

enum TextFieldType {
  standard,
  search,
  dropdown,
  datePicker,
  timePicker,
}

class CustomTextField<T> extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool isEnabled;
  final bool readOnly;
  final int maxLines;
  final TextFieldType type;

  // Dropdown specific
  final List<DropdownMenuItem<T>>? dropdownItems;
  final T? dropdownValue;
  final ValueChanged<T?>? onDropdownChanged;

  // Date/Time specific
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<TimeOfDay>? onTimeSelected;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onTap,
    this.isEnabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.type = TextFieldType.standard,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.onDateSelected,
    this.onTimeSelected,
  });

  // Factory Constructor: Search Variant
  factory CustomTextField.search({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Search doctors, clinics, specialties...',
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
  }) {
    return CustomTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      type: TextFieldType.search,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(
        Icons.search_rounded,
        color: AppColors.textTertiary,
        size: 22.0,
      ),
      suffixIcon: controller != null && controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(
                Icons.clear_rounded,
                color: AppColors.textTertiary,
                size: 20.0,
              ),
              onPressed: () {
                controller.clear();
                onChanged?.call('');
                onClear?.call();
              },
            )
          : null,
      onChanged: onChanged,
    );
  }

  // Factory Constructor: Dropdown Variant
  factory CustomTextField.dropdown({
    Key? key,
    String? labelText,
    String? hintText,
    required List<DropdownMenuItem<T>> items,
    required T? value,
    required ValueChanged<T?> onChanged,
    FormFieldValidator<T>? validator,
    Widget? prefixIcon,
  }) {
    return CustomTextField<T>(
      key: key,
      labelText: labelText,
      hintText: hintText,
      type: TextFieldType.dropdown,
      dropdownItems: items,
      dropdownValue: value,
      onDropdownChanged: onChanged,
      prefixIcon: prefixIcon,
    );
  }

  // Factory Constructor: Date Picker Variant
  factory CustomTextField.datePicker({
    Key? key,
    BuildContext? context,
    TextEditingController? controller,
    String? labelText,
    String hintText = 'Select date (DD/MM/YYYY)',
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    ValueChanged<DateTime>? onDateSelected,
    FormFieldValidator<String>? validator,
  }) {
    return CustomTextField(
      key: key,
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      readOnly: true,
      type: TextFieldType.datePicker,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateSelected: onDateSelected,
      validator: validator,
      prefixIcon: const Icon(
        Icons.calendar_today_rounded,
        color: AppColors.textTertiary,
        size: 20.0,
      ),
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textSecondary,
      ),
    );
  }

  // Factory Constructor: Time Picker Variant
  factory CustomTextField.timePicker({
    Key? key,
    BuildContext? context,
    TextEditingController? controller,
    String? labelText,
    String hintText = 'Select time',
    ValueChanged<TimeOfDay>? onTimeSelected,
    FormFieldValidator<String>? validator,
  }) {
    return CustomTextField(
      key: key,
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      readOnly: true,
      type: TextFieldType.timePicker,
      onTimeSelected: onTimeSelected,
      validator: validator,
      prefixIcon: const Icon(
        Icons.access_time_rounded,
        color: AppColors.textTertiary,
        size: 20.0,
      ),
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textSecondary,
      ),
    );
  }

  Future<void> _handleDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.darkTextPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      if (controller != null) {
        controller!.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      }
      onDateSelected?.call(pickedDate);
    }
  }

  Future<void> _handleTimePicker(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.darkTextPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      if (controller != null) {
        final hour = pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
        final minute = pickedTime.minute.toString().padLeft(2, '0');
        final period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
        controller!.text = '$hour:$minute $period';
      }
      onTimeSelected?.call(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 8.0),
        ],
        if (type == TextFieldType.dropdown)
          DropdownButtonFormField<T>(
            initialValue: dropdownValue,
            items: dropdownItems,
            onChanged: isEnabled ? onDropdownChanged : null,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
            ),
            style: AppTextStyles.bodyLarge,
            decoration: _buildInputDecoration(context),
          )
        else
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            validator: validator,
            onChanged: onChanged,
            enabled: isEnabled,
            readOnly: readOnly ||
                type == TextFieldType.datePicker ||
                type == TextFieldType.timePicker,
            maxLines: maxLines,
            onTap: () {
              if (type == TextFieldType.datePicker) {
                _handleDatePicker(context);
              } else if (type == TextFieldType.timePicker) {
                _handleTimePicker(context);
              } else {
                onTap?.call();
              }
            },
            style: AppTextStyles.bodyLarge,
            decoration: _buildInputDecoration(context),
          ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.bodyRegular.copyWith(
        color: AppColors.textTertiary,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.cardBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.border, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.border, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.errorRed, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
      ),
    );
  }
}
