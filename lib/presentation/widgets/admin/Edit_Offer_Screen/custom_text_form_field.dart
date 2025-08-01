import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.titleController,
    this.validator,
    required this.labelText,
  });

  final TextEditingController titleController;
  final String labelText;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color.fromARGB(255, 165, 101, 56);

    return TextFormField(
      controller: titleController,
      maxLines: labelText == 'عنوان العرض' ? 1 : 3,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: mainColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (val) => validator!(val),
    );
  }
}
