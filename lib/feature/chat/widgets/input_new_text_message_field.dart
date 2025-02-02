import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

class InputNewTextMessageField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback sendMessage;

  const InputNewTextMessageField({
    super.key,
    required this.controller,
    required this.sendMessage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InputNewTextMessageFieldState createState() =>
      _InputNewTextMessageFieldState();
}

class _InputNewTextMessageFieldState extends State<InputNewTextMessageField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Инициализация FocusNode
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Освобождение ресурсов при удалении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 10, 40),
      child: Row(
        children: [
          Expanded(
            flex: 4, // Proportionally reduces width of the TextField in row
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode, // Привязка FocusNode к TextField
                style: const TextStyle(color: playerDarkBlue),
                decoration: InputDecoration(
                  labelText: 'Geben Sie Ihre Nachricht ein...',
                  labelStyle: const TextStyle(color: Colors.lightBlue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 3.5,
                    ),
                  ),
                ),
                // Обработчик события нажатия клавиши Enter
                onSubmitted: (value) {
                  widget.sendMessage();
                  widget.controller
                      .clear(); // Очищает поле ввода после отправки сообщения
                  _focusNode.requestFocus(); // Возвращает фокус на поле ввода
                },
              ),
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons_chat/send_message.png',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
            onPressed: () {
              widget.sendMessage();
              widget.controller
                  .clear(); // Очищает поле ввода после отправки сообщения
              _focusNode.requestFocus(); // Возвращает фокус на поле ввода
            },
          ),
        ],
      ),
    );
  }
}
