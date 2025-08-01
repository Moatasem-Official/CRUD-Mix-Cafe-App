import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Add_Offer_Screen/custom_build_date_time_picker.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Add_Offer_Screen/custom_build_section.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Add_Offer_Screen/helper_functions.dart';

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
      title: 'جدولة العرض',
      icon: Icons.calendar_month,
      child: Column(
        children: [
          CustomBuildDateTimePicker(
            label: 'تاريخ ووقت البداية',
            dateTime: startDate,
            onTap: () => HelperFunctions.pickDateTime(
              isStartDate: true,
              context: context,
              onDateSelected: (date) => onStartDateSelected?.call(date),
            ),
          ),
          const SizedBox(height: 16),
          CustomBuildDateTimePicker(
            label: 'تاريخ ووقت النهاية',
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
