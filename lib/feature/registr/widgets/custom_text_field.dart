import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final int? maxLength;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.maxLength,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double inputHeight = screenHeight * 0.005;
    // Определяем коэффициент в зависимости от ориентации
    double fontSizeCoefficient =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.05
            : 0.04;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        width: double.infinity, // Используем всю доступную ширину
        child: TextField(
          cursorColor: Theme.of(context).inputDecorationTheme.labelStyle?.color,
          controller: controller,
          obscureText: obscureText,
          maxLength: maxLength,
          style: TextStyle(
            fontSize: screenWidth * fontSizeCoefficient,
            color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
          ),
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon),
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(vertical: inputHeight),
          ),
        ),
      ),
    );
  }
}
