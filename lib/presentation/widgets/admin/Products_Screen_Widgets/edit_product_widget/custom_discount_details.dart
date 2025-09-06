import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'custom_date_time_picker.dart';
import 'custom_text_field.dart';

class CustomDiscountDetails extends StatelessWidget {
  const CustomDiscountDetails({
    super.key,
    required this.discountController,
    required this.startDate,
    required this.endDate,
    required this.onStartDateTap,
    required this.onEndDateTap,
  });

  final TextEditingController discountController;
  final DateTime startDate;
  final DateTime endDate;

  final void Function() onStartDateTap, onEndDateTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 16.0),
      child: Column(
        children: [
          CustomTextField(
            controller: discountController,
            label: 'Discount Percentage (%)',
            icon: IconlyLight.discount,
            keyboardType: TextInputType.number,
            isNumber: true,
          ),
          const SizedBox(height: 16),
          // --- حقول التاريخ والوقت الجديدة ---
          Row(
            children: [
              Expanded(
                child: CustomDateTimePicker(
                  label: 'Start Discount Date',
                  date: startDate,
                  onTap: onStartDateTap,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomDateTimePicker(
                  label: 'End Discount Date',
                  date: endDate,
                  onTap: onEndDateTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
