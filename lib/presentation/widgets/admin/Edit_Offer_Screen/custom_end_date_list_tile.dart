import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Edit_Offer_Screen/helper_functions.dart';

class CustomEndDateListTile extends StatelessWidget {
  const CustomEndDateListTile({
    super.key,
    required this.selectedDate,
    required this.updateSelectedDate,
  });

  final DateTime selectedDate;

  final Function(DateTime) updateSelectedDate;

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color.fromARGB(255, 165, 101, 56);

    return ListTile(
      title: Text(
        'تاريخ الانتهاء: ${DateFormat('yyyy/MM/dd – hh:mm a').format(selectedDate)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.calendar_month, color: mainColor),
      onTap: () => HelperFunctions.pickDateTime(
        context,
        selectedDate,
        updateSelectedDate,
      ),
    );
  }
}
