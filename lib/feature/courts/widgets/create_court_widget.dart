import 'package:flutter/material.dart';

class CreateCourtWidget extends StatelessWidget {
  const CreateCourtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Neuen Basketballplatz erstellen",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(labelText: "Name des Platzes"),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: "Standort "),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Platz Foto"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Google Standort"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Platz hinzufügen"),
          ),
        ],
      ),
    );
  }
}
