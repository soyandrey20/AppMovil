import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputDecoration({
    required String hintText,
    required String labelText,
    required Icon icon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple.shade300),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: icon,
    );
  }
}
