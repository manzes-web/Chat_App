import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final labeltext;
  final obscureText;
  final controller;
  const MyTextfield({
    super.key,
    required this.labeltext,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        labelStyle:
            TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
