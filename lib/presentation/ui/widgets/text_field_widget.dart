import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controllerTE, required this.hint});
  final TextEditingController controllerTE;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerTE,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
