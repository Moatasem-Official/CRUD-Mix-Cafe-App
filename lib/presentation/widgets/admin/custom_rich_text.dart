import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key, required this.checked, this.onChanged});

  final bool checked;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: onChanged,
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
                    text: 'I Agree To The ',
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
