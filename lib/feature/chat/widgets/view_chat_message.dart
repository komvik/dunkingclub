import 'package:dunkingclub/config/colors.dart';
import 'package:flutter/material.dart';

class ViewChatMessage extends StatelessWidget {
  final String message;

  const ViewChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    //
    final parts = message.split(': ');
    final sender = parts[0];
    final msg = parts.length > 1 ? parts[1] : '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: deepKelp,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                text: '$sender: ',
                style: sender == "Du"
                    ? const TextStyle(
                        color: hydration, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: oceanMeditation, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: msg,
                style: const TextStyle(color: headInTheClouds),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
