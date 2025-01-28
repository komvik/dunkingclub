import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

final SnackBarThemeData customSnackBarTheme = SnackBarThemeData(
  backgroundColor: const Color.fromARGB(255, 70, 197, 252),
  contentTextStyle:
      const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
  actionTextColor: Colors.yellow,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  behavior: SnackBarBehavior.floating,
);
