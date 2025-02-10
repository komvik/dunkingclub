import 'package:dunkingclub/feature/registr/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class RegistrationAlertDialog extends StatelessWidget {
  const RegistrationAlertDialog({
    super.key,
    required this.answer,
  });

  final String? answer;

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
        "$answer",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "If you made a mistake in typing your email",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              },
              child: const Text(
                'Return to activation',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            // Отступ между кнопками
            const Text(
              "If you are creating a new player profile",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Цвет кнопки
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Continue registration explanation how"),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                'Continue registration',
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
