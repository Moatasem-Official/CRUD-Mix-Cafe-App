import 'package:flutter/material.dart';

class CustomRichText extends StatefulWidget {
  const CustomRichText({super.key});

  @override
  State<CustomRichText> createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  var checked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = value!;
              });
            },
            activeColor: Color.fromARGB(255, 165, 101, 56),
            checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 100,
            ),
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'I agree to the ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Terms & Conditions ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 165, 101, 56),
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Color.fromARGB(255, 165, 101, 56),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
