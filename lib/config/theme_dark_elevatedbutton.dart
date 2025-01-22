import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

// Кастомная тема для ElevatedButton
final ButtonStyle customElevatedButtonStyle = ElevatedButton.styleFrom(
  // Цвет текста кнопки
  foregroundColor: const Color.fromARGB(255, 255, 255, 255),

  backgroundColor: playerDarkBlue,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(22.0), // Радиус скругления углов кнопки
    side: const BorderSide(
      color: Colors.blue, // Цвет рамки
      width: 2.0, // Толщина рамки
    ),
  ),
  padding: const EdgeInsets.symmetric(
      vertical: 1.0, horizontal: 2.0), // Отступы внутри кнопки
  elevation: 5.0, // Тень кнопки
  textStyle: const TextStyle(
    fontSize: 24.0, // Размер шрифта
    //fontWeight: FontWeight.bold, // Жирность шрифта
  ),
);

// Кастомная тема для кнопок с ошибкой (например, для Cancel кнопки)
final ButtonStyle customElevatedButtonErrorStyle = ElevatedButton.styleFrom(
// Цвет текста кнопки
  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  backgroundColor: Colors.red, // Цвет текста для кнопки ошибки
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(22.0), // Радиус скругления углов кнопки
    side: const BorderSide(
      color: Colors.blue, // Цвет рамки
      width: 2.0, // Толщина рамки
    ),
  ),
  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
  elevation: 5.0,
  textStyle: const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  ),
);
