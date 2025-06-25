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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 253, 236, 224),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(imagePath, width: 100, height: 100),
              ),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 213, 120, 53),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => onTap(),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
