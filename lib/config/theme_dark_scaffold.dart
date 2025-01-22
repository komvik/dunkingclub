import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

final ThemeData customScaffoldTheme = ThemeData(
  scaffoldBackgroundColor:
      const Color.fromARGB(255, 0, 0, 0), // фон для всех Scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 0, 0, 0), // фона для AppBar
    //elevation: 4.0, // Тень под AppBar
    titleTextStyle: TextStyle(
        color: oceanMeditation, fontSize: 22), // Цвет и размер текста в AppBar
  ),
);
