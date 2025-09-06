import 'package:flutter/material.dart';
import 'custom_build_date_time_picker.dart';
import 'custom_build_section.dart';
import 'helper_functions.dart';

class OfferStartEndDateTimeSection extends StatelessWidget {
  const OfferStartEndDateTimeSection({
    super.key,
    this.startDate,
    this.endDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime startDate)? onStartDateSelected;
  final Function(DateTime endDate)? onEndDateSelected;

  @override
  Widget build(BuildContext context) {
    return CustomBuildSection(
      title: 'Offer Schedule',
      icon: Icons.calendar_month,
      child: Column(
        children: [
          CustomBuildDateTimePicker(
            label: 'Start Date & Time',
            dateTime: startDate,
            onTap: () => HelperFunctions.pickDateTime(
              isStartDate: true,
              context: context,
              onDateSelected: (date) => onStartDateSelected?.call(date),
            ),
          ),
          const SizedBox(height: 16),
          CustomBuildDateTimePicker(
            label: 'End Date & Time',
            dateTime: endDate,
            onTap: () => HelperFunctions.pickDateTime(
              isStartDate: false,
              context: context,
              onDateSelected: (date) => onEndDateSelected?.call(date),
            ),
          ),
        ],
      ),
    );
  }
}
