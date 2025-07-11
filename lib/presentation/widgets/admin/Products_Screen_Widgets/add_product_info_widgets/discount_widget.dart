import 'package:flutter/material.dart';
import 'custom_date_field.dart';
import 'custom_styled_field.dart';
import 'custom_time_field.dart';

class DiscountWidget extends StatelessWidget {
  DiscountWidget({
    super.key,
    required this.discountPercentageController,
    required this.startDateController,
    required this.endDateController,
    required this.startDate,
    required this.endDate,
    required this.timeStartPicked,
    required this.timeEndPicked,
    required this.onStartDatePicked,
    required this.onEndDatePicked,
    required this.onStartTimePicked,
    required this.onEndTimePicked,
    required this.startTimeController,
    required this.endTimeController,
  });

  final TextEditingController discountPercentageController;
  final TextEditingController startDateController;
  final TextEditingController startTimeController;
  final TextEditingController endDateController;
  final TextEditingController endTimeController;
  DateTime startDate;
  DateTime endDate;
  TimeOfDay timeStartPicked;
  TimeOfDay timeEndPicked;
  final Function(DateTime) onStartDatePicked;
  final Function(DateTime) onEndDatePicked;
  final Function(TimeOfDay) onStartTimePicked;
  final Function(TimeOfDay) onEndTimePicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Discount Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF8B4513),
          ),
        ),
        const SizedBox(height: 8),
        CustomStyledField(
          controller: discountPercentageController,
          validatorMessage: 'Please enter discount percentage',
          maxLines: 1,
          label: 'Discount Percentage (%)',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter discount percentage';
            }
            final percentage = double.tryParse(value);
            if (percentage == null || percentage < 0 || percentage > 100) {
              return 'Enter a valid percentage (0-100)';
            }
            return null;
          },
        ),
        CustomDateField(
          controller: startDateController,
          label: 'Start Discount Date',
          context: context,
          selectedDate: startDate,
          onDatePicked: onStartDatePicked,
        ),
        CustomTimeField(
          controller: startTimeController,
          label: 'Start Discount Time',
          context: context,
          selectedTime: timeStartPicked,
          onTimePicked: onStartTimePicked,
        ),
        CustomDateField(
          controller: endDateController,
          label: 'End Discount Date',
          context: context,
          selectedDate: endDate,
          onDatePicked: onEndDatePicked,
        ),
        CustomTimeField(
          controller: endTimeController,
          label: 'End Discount Time',
          context: context,
          selectedTime: timeEndPicked,
          onTimePicked: onEndTimePicked,
        ),
      ],
    );
  }
}
