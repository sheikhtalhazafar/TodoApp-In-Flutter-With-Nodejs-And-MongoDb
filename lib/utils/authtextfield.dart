// lib/widgets/auth_text_field.dart
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController controller;
  final TextInputType keyboardType;

   const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
