import 'package:flutter/material.dart';

class CreateAvatarAlertDialog extends StatelessWidget {
  const CreateAvatarAlertDialog({
    super.key,
    required this.inputtext,
    required this.onPickImage, // Функция для выбора изображения
    required this.onCancel, // Функция для отмены
  });

  final String? inputtext;
  final VoidCallback onPickImage; // Функция для выбора изображения
  final VoidCallback onCancel; // Функция для отмены

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "CHOOSE AN ACTION",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      backgroundColor: Colors.grey[900], // Цвет фона диалога
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.blue, width: 2), // Цвет рамки
      ),
      content: Text(
        "$inputtext",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Цвет кнопки
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Закрываем диалог
                onPickImage(); // Вызов функции выбора изображения
              },
              child: const Text(
                'Choose Image',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            // Отступ между кнопками
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Цвет кнопки
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Просто закрываем диалог
                onCancel(); // Вызываем функцию отмены
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
