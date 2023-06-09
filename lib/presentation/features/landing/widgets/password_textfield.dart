import 'package:billsplit_flutter/extensions.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? error;
  final String hintText;

  const PasswordTextField(
      {Key? key,
      required this.controller,
      required this.error,
      required this.hintText})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: widget.error,
        suffixIcon: IconButton(
          icon: Icon(builder(() {
            if (showPassword) {
              return Icons.visibility;
            } else {
              return Icons.visibility_off;
            }
          })),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        border: InputBorder.none,
        hintText: widget.hintText,
      ),
      obscureText: !showPassword,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
