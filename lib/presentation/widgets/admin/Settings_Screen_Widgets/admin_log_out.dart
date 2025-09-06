import 'package:flutter/material.dart';

class AdminLogOut extends StatelessWidget {
  const AdminLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'LOG OUT',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 165, 101, 56),
        ),
      ),
      content: const Text('Do You Want To Log Out ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'No',
            style: TextStyle(color: Color.fromARGB(255, 165, 101, 56)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 165, 101, 56),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
