import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String inputText;

  const InputField({super.key, required this.inputText});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Color(0xFFf6fed1)),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0xFFf6fed1), // Outline color when focused
            width: 2.0, // Outline thickness when focused
          ),
        ),
        labelText: widget.inputText,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        floatingLabelStyle: TextStyle(
          color: Color(0xFFf6fed1),
        ),
      ),
    );
  }
}
