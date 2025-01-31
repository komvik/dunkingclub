import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

final ThemeData customScaffoldTheme = ThemeData(
  scaffoldBackgroundColor:
      const Color.fromARGB(255, 46, 46, 46), // фон для всех Scaffold 2E2E2E
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 46, 46, 46), // фона для AppBar
    //elevation: 4.0, // Тень под AppBar
    titleTextStyle: TextStyle(
        color: oceanMeditation, fontSize: 22), // Цвет и размер текста в AppBar
  ),
);
