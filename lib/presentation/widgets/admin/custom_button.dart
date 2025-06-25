import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 165, 101, 56),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
