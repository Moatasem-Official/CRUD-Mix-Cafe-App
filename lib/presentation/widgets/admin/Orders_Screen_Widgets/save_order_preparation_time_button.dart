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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Please select a preparation time first."),
              backgroundColor: Colors.red[400],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          final preparationDuration = Duration(
            hours: estimatedDuration!.hour,
            minutes: estimatedDuration!.minute,
          );

          // هنا ممكن تحفظها في قاعدة البيانات أو أي مكان تاني
          print(formatDuration(preparationDuration));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Preparation time set to ${formatDuration(preparationDuration)}",
              ),
              backgroundColor: Colors.brown[400],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      icon: const Icon(Icons.timer_outlined),
      label: const Text("Save Preparation Time"),
      style: FilledButton.styleFrom(
        backgroundColor: Colors.brown[400],
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
