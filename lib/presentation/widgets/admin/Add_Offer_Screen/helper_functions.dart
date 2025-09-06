import 'dart:io';

import 'package:flutter/material.dart';

class HelperFunctions {
  static Future<void> pickDateTime({
    required bool isStartDate,
    required BuildContext context,
    required Function(DateTime) onDateSelected,
  }) async {
    final Color primaryColor = const Color.fromARGB(255, 165, 101, 56);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    onDateSelected(selectedDateTime); // ✅ هنا بنرجع التاريخ الجديد
  }

  static Future<bool> submitOffer(
    BuildContext rootContext,
    GlobalKey<FormState> formKey,
    DateTime? startDate,
    DateTime? endDate,
    File? offerImage,
  ) async {
    final isValid = formKey.currentState!.validate();

    if (!isValid || startDate == null || endDate == null) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        const SnackBar(
          content: Text("Please Fill In All The Required Fields."),
        ),
      );
      return false;
    }

    if (offerImage == null) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        const SnackBar(content: Text("Please Select Offer Image.")),
      );
      return false;
    }

    if (endDate.isBefore(startDate)) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        const SnackBar(content: Text("End Date Must Be After Start Date.")),
      );
      return false;
    }

    return true;
  }

  static InputDecoration buildInputDecoration(String label, IconData icon) {
    final Color primaryColor = const Color.fromARGB(255, 165, 101, 56);

    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor.withOpacity(0.7)),
      labelStyle: TextStyle(color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
