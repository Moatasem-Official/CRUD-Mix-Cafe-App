import 'package:flutter/material.dart';

class CustomOrdersDropdownMenuItem extends StatelessWidget {
  const CustomOrdersDropdownMenuItem({
    super.key,
    required this.menuHintText,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.label1,
    required this.label2,
    required this.label3,
  });

  final String menuHintText;
  final String value1, value2, value3;
  final String label1, label2, label3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
        child: DropdownMenu<String>(
          hintText: menuHintText,
          textStyle: const TextStyle(
            color: Color(0xFF6F4E37),
            fontWeight: FontWeight.bold,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          trailingIcon: Icon(Icons.arrow_drop_down, color: Color(0xFF6F4E37)),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFFF9F9F9)),
            elevation: WidgetStatePropertyAll(6),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          dropdownMenuEntries: [
            DropdownMenuEntry(value: value1, label: label1),
            DropdownMenuEntry(value: value2, label: label2),
            DropdownMenuEntry(value: value3, label: label3),
          ],
        ),
      ),
    );
  }
}
