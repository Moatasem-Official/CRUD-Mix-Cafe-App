import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class HelperFunctions {
  static Future<void> showDeleteConfirmationDialog(
    BuildContext context,
    String orderId,
    Function() onDelete,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          icon: const Icon(
            IconlyBold.delete,
            color: Color.fromARGB(255, 165, 101, 56),
            size: 32,
          ),
          title: Text(
            'Delete Order ?',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Are you sure you want to permanently delete this order? This action cannot be undone.',
            style: GoogleFonts.poppins(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 165, 101, 56),
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                await onDelete();
              },
            ),
          ],
        );
      },
    );
  }

  static String formatDate(DateTime? timestamp) {
    if (timestamp == null) return '---';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  static String formatTime(DateTime? timestamp) {
    if (timestamp == null) return '---';
    final String period = timestamp.hour < 12 ? 'AM' : 'PM';
    final int hour = timestamp.hour % 12 == 0 ? 12 : timestamp.hour % 12;
    return '$hour:${timestamp.minute.toString().padLeft(2, '0')} $period';
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    String result = '';
    if (hours > 0) {
      result += '$hours hr ';
    }
    if (minutes > 0) {
      result += '$minutes min';
    }
    return result.isEmpty ? '0 min' : result.trim();
  }

  static Future<void> selectTime(
    BuildContext context,
    Function(TimeOfDay) onTimeSelected,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      // Start from 00:00 to feel like a duration picker
      initialTime: const TimeOfDay(hour: 0, minute: 15),
      // This builder is the key to make it a duration picker
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          // Force 24-hour format for duration selection
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green.shade700;
      case 'pending':
        return Colors.orange.shade700;
      case 'cancelled':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}
