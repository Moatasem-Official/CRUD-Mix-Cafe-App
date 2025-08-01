import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Add_Offer_Screen/helper_functions.dart';

class CustomBuildDateTimePicker extends StatelessWidget {
  const CustomBuildDateTimePicker({
    super.key,
    required this.label,
    required this.dateTime,
    required this.onTap,
  });

  final String label;
  final DateTime? dateTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String formattedDateTime = dateTime != null
        ? DateFormat('yyyy-MM-dd – hh:mm a', 'ar').format(dateTime!)
        : 'لم يتم التحديد';

    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: HelperFunctions.buildInputDecoration(
          label,
          Icons.date_range,
        ),
        child: Text(
          formattedDateTime,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
