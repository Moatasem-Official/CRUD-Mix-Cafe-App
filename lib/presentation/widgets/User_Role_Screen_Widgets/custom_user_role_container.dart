import 'package:flutter/material.dart';

class CustomUserRoleContainer extends StatelessWidget {
  const CustomUserRoleContainer({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.imagePath,
  });

  final String buttonText;
  final Function() onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: SizedBox(
          width: double.infinity,
          height: 110,
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 20,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD37A43),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
