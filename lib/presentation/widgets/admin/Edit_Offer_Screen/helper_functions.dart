import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../data/services/cloudinary/cloudinary_services.dart';

class HelperFunctions {
  static void pickDateTime(
    BuildContext context,
    DateTime selectedDate,
    Function(DateTime) updateSelectedDate,
  ) async {
    final Color mainColor = const Color.fromARGB(255, 165, 101, 56);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData(primaryColor: mainColor),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
      builder: (context, child) {
        return Theme(
          data: ThemeData(primaryColor: mainColor),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    final newDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    updateSelectedDate(newDateTime);
  }

  static bool saveForm(
    TextEditingController titleController,
    TextEditingController descController,
    DateTime selectedDate,
    File? image,
    GlobalKey<FormState> formKey,
  ) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
