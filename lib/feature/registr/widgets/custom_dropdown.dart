import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final List<DropdownMenuItem<String>> items;
  final String label;
  final IconData icon;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.label,
    required this.icon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double inputHeight = screenHeight * 0.005;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items,
          dropdownColor: playerDarkBlue,
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
