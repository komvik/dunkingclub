import 'package:flutter/material.dart';
import 'package:dunkingclub/config/colors.dart'; // Подключаем ваши цвета

// Кастомизация TextField
InputDecoration customTextFieldDecoration({
  required String labelText,
  required IconData icon,
  String? errorText,
}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(
        color: Color.fromARGB(255, 119, 249, 123)), // Цвет текста в лейбле
    prefixIcon: Icon(icon,
        color: const Color.fromARGB(255, 255, 215, 0)), // Цвет иконки
    errorText: errorText,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: oceanMeditation),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
          width: 2.0), // Цвет при фокусе
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Color.fromARGB(255, 250, 250, 250),
          width: 1.0), // Цвет для неактивного состояния
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0), // Высота поля
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Color.fromARGB(255, 209, 215, 219),
          width: 2.0), // Ошибка, когда поле в фокусе
    ),
  );
}

// Кастомная тема для TextField
InputDecorationTheme customTextFieldTheme = const InputDecorationTheme(
  labelStyle: TextStyle(
    color: peachSmoothie,
  ), // Стиль лейблов
  prefixIconColor: Color.fromARGB(255, 177, 92, 0), // Цвет иконок
  errorStyle: TextStyle(color: Colors.red), // Цвет ошибки

  //focusColor: Color.fromARGB(255, 255, 215, 0),

  //фон для поля ввода:
  //filled: true,
  //fillColor: Color.fromARGB(255, 102, 87, 87), // Светлый фон
  //border
  border: OutlineInputBorder(
    borderSide: BorderSide(color: oceanMeditation),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: oceanMeditation, width: 2.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: oceanMeditation, width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  ),
);
