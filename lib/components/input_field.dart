import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';

class InputField extends StatefulWidget {
  final String inputText;
  final TextEditingController controller;

  const InputField(
      {super.key, required this.inputText, required this.controller});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: AppColors.secondaryColor),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor, // Outline color when focused
            width: 2.0, // Outline thickness when focused
          ),
        ),
        labelText: widget.inputText,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
