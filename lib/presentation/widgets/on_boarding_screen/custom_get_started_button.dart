import 'package:flutter/material.dart';

class CustomGetStartedButton extends StatelessWidget {
  const CustomGetStartedButton({super.key, required this.onGetStarted});

  final Function() onGetStarted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onGetStarted(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 165, 101, 56),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
