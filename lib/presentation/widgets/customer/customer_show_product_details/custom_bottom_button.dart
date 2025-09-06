import 'package:flutter/material.dart';

class CustomBottomButton extends StatelessWidget {
  const CustomBottomButton({
    super.key,
    required this.onPressed,
    required this.isAvailable,
  });

  final Function()? onPressed;

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9C6B1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            shadowColor: Colors.black26,
          ),
          onPressed: isAvailable ? onPressed : null,
          child: const Text(
            'Add to Cart',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
