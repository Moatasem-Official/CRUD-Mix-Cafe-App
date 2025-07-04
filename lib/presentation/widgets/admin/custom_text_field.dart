import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.validator,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var isVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          autofillHints: widget.hintText == 'Email'
              ? [AutofillHints.email]
              : null,
          obscureText: isVisiblePassword && widget.hintText == 'Password'
              ? true
              : isVisiblePassword && widget.hintText == 'Confirm Password'
              ? true
              : false,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.hintText == 'Email'
                  ? Icons.email
                  : widget.hintText == 'Name'
                  ? Icons.person
                  : Icons.lock,
              color: const Color(0xFF6F4E37),
            ),
            suffixIcon:
                widget.hintText == 'Password' ||
                    widget.hintText == 'Confirm Password'
                ? IconButton(
                    onPressed: showOrHidePassword,
                    icon: isVisiblePassword
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: Color(0xFF6F4E37),
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Color(0xFF6F4E37),
                          ),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[600]),
            contentPadding: const EdgeInsets.all(12),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void showOrHidePassword() {
    isVisiblePassword = !isVisiblePassword;
    setState(() {});
  }
}
