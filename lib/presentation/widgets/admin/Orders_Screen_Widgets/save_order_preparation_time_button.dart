import 'package:flutter/material.dart';

class SaveOrderPreparationTimeButton extends StatelessWidget {
  const SaveOrderPreparationTimeButton({
    super.key,
    required this.estimatedDuration,
  });

  final TimeOfDay? estimatedDuration;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        if (estimatedDuration == null) {
          _showCustomSnackBar(
            context,
            message: "Please select a preparation time first.",
            isError: true,
          );
        } else {
          final preparationDuration = Duration(
            hours: estimatedDuration!.hour,
            minutes: estimatedDuration!.minute,
          );

          final durationText = formatDuration(preparationDuration);

          // TODO: Save to Firebase or use elsewhere
          print("Preparation time set to: $durationText");

          _showCustomSnackBar(
            context,
            message: "Preparation time set to $durationText",
            isError: false,
          );
        }
      },
      icon: const Icon(Icons.timer_outlined, size: 20),
      label: const Text("Save Preparation Time"),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF8B4513),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _showCustomSnackBar(
    BuildContext context, {
    required String message,
    required bool isError,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red[400] : Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return "$hours h $minutes m";
  } else if (hours > 0) {
    return "$hours h";
  } else {
    return "$minutes m";
  }
}
