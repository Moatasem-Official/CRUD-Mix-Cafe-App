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
      padding: const EdgeInsetsDirectional.all(16.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        autofillHints: widget.hintText == 'Email'
            ? [AutofillHints.email]
            : null,
        obscureText:
            (widget.hintText == 'Password' ||
                widget.hintText == 'Confirm Password') &&
            !isVisiblePassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            widget.hintText == 'Email'
                ? Icons.email
                : widget.hintText == 'Name'
                ? Icons.person
                : Icons.lock,
            color: Color.fromARGB(255, 165, 101, 56),
          ),
          suffixIcon:
              widget.hintText == 'Password' ||
                  widget.hintText == 'Confirm Password'
              ? IconButton(
                  onPressed: showOrHidePassword,
                  icon: isVisiblePassword
                      ? const Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 165, 101, 56),
                        )
                      : const Icon(
                          Icons.remove_red_eye,
                          color: Color.fromARGB(255, 165, 101, 56),
                        ),
                )
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          contentPadding: const EdgeInsetsDirectional.all(12),
        ),
      ),
    );
  }

  void showOrHidePassword() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }
}
