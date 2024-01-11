import 'package:flutter/material.dart';

enum TextFieldType { email, password, number, text }

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    this.icon,
    this.hintText,
    this.inputType = TextFieldType.text,
    this.controller,
  });

  final IconData? icon;
  final TextFieldType inputType;

  final String? hintText;
  final TextEditingController? controller;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  TextInputType? getKeyboardType() {
    switch (widget.inputType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: getKeyboardType(),
        obscureText: widget.inputType == TextFieldType.password
            ? !isPasswordVisible
            : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          if (widget.inputType == TextFieldType.email &&
              !value.isValidEmail()) {
            return 'Please enter valid email';
          }
          return null;
        },
        controller: widget.controller,
        decoration: InputDecoration(
            suffixIcon: widget.inputType == TextFieldType.password
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
            ),
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: 18,
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(letterSpacing: .9, color: Colors.grey)),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
