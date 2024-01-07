import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    this.icon,
    this.hintText,
    this.controller,
  });

  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
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
