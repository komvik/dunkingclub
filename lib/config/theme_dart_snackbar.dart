import 'package:flutter/material.dart';

final SnackBarThemeData customSnackBarTheme = SnackBarThemeData(
  backgroundColor: Colors.grey[900],
  contentTextStyle: const TextStyle(
    color: Colors.white70,
    fontSize: 20,
  ),
  actionTextColor: Colors.yellow,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
    side: const BorderSide(
      color: Colors.blue, // Цвет бордюра
      width: 2, // Толщина бордюра
    ),
  ),
  behavior: SnackBarBehavior.floating,
);
