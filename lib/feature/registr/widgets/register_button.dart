import 'package:dunkingclub/feature/registr/widgets/validation.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  // Параметры, которые принимает виджет
  final TextEditingController emailController;
  final TextEditingController cityCodeController;
  final TextEditingController passwordController;
  final String? selectedContinent;
  final String? selectedCountry;
  final bool isFormSubmitted;
  final void Function(Map<String, String> userData)
      onRegister; // Callback для обработки данных

  const RegisterButton({
    super.key,
    required this.emailController,
    required this.cityCodeController,
    required this.passwordController,
    required this.selectedContinent,
    required this.selectedCountry,
    required this.isFormSubmitted,
    required this.onRegister, // Принимаем функцию для регистрации
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Проверка всех полей формы на валидность
        if (_validateForm()) {
          // Собираем данные в Map
          final userData = {
            'email': emailController.text,
            'continent': selectedContinent!,
            'country': selectedCountry!,
            'cityCode': cityCodeController.text,
            'password': passwordController.text,
          };

          // Вызываем внешний callback для обработки данных
          onRegister(userData);
        } else {
          // Показать ошибку или уведомление, если поля не валидны
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please fill in all fields correctly.')),
          );
        }
      },
      child: const Text('Register or Login'),
    );
  }

  // Валидация формы
  bool _validateForm() {
    return validateEmail(emailController.text) == null &&
        selectedContinent != null &&
        selectedCountry != null &&
        validateCityCode(cityCodeController.text) == null &&
        validatePassword(passwordController.text) == null;
  }
}
