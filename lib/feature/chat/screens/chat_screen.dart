import 'package:dunkingclub/config/colors.dart';
import 'package:dunkingclub/feature/chat/repositories/bot_answers.dart';
import 'package:dunkingclub/feature/chat/widgets/chat_app_bar.dart';
import 'package:dunkingclub/feature/chat/widgets/input_new_text_message_field.dart';
import 'package:dunkingclub/feature/chat/widgets/view_chat_message.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = []; // Messages list
  final _controller = TextEditingController(); // Textcontroller

  // _____________________________________________ Sending message
  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isEmpty) return;
    setState(() {
      _messages.insert(0, "Du: $message");
    });
    _controller.clear();
    _sendBotReply();
  }

  // __________________________________________  Auto-reply from a bot
  void _sendBotReply() {
    final random = Random();
    final botMessage = botReplies[random.nextInt(botReplies.length)];
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.insert(0, "Player: $botMessage");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headInTheClouds,
      appBar: const ChatAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              hydration,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, // Make  message  on top
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ViewChatMessage(message: _messages[index]);
                },
              ),
            ),
            InputNewTextMessageField(
              controller: _controller,
              sendMessage: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
