import 'package:flutter/material.dart';
import '../../../../data/services/auth/auth_service.dart';

class EditWorkingHours extends StatelessWidget {
  EditWorkingHours({
    super.key,
    required this.startTimeController,
    required this.endTimeController,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.authService,
  });

  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final AuthService authService;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'مواعيد العمل',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8B4513),
        ),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickTime({required bool isStart}) async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              setState(() {
                if (isStart) {
                  selectedStartTime = pickedTime;
                  startTimeController.text = pickedTime.format(context);
                } else {
                  selectedEndTime = pickedTime;
                  endTimeController.text = pickedTime.format(context);
                }
              });
            }
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startTimeController,
                readOnly: true,
                onTap: () => pickTime(isStart: true),
                decoration: const InputDecoration(
                  labelText: 'وقت البداية',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: endTimeController,
                readOnly: true,
                onTap: () => pickTime(isStart: false),
                decoration: const InputDecoration(
                  labelText: 'وقت النهاية',
                  prefixIcon: Icon(Icons.access_time_filled),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513),
          ),
          onPressed: () {
            if (selectedStartTime == null || selectedEndTime == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('يجب تحديد وقت البداية والنهاية')),
              );
              return;
            }

            final start = selectedStartTime!.format(context);
            final end = selectedEndTime!.format(context);

            authService.updateField('starting_working_hours', start.toString());
            authService.updateField('finishing_working_hours', end.toString());

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم التحديث من $start إلى $end')),
            );
          },
          child: const Text('تحديث'),
        ),
      ],
    );
  }
}
