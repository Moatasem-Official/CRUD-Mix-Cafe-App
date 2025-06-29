import 'package:flutter/material.dart';

class CustomCategoriesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomCategoriesAppBar({
    super.key,
    required this.onPressed,
    required this.title,
    required this.buttonText,
  });
  final String? title;
  final String? buttonText;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            title!,
            style: TextStyle(
              color: Color(0xFF6F4E37),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 154, 97, 57),
              borderRadius: BorderRadius.circular(10),
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: onPressed,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 30),
                  Text(
                    buttonText!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(170);
}
