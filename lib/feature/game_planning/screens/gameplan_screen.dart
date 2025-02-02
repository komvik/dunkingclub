import 'package:dunkingclub/feature/courts/repositories/court_data.dart';
import 'package:flutter/material.dart';

class GamePlanningScreen extends StatefulWidget {
  const GamePlanningScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GamePlanningScreenState createState() => _GamePlanningScreenState();
}

class _GamePlanningScreenState extends State<GamePlanningScreen> {
  final TextEditingController _timeController = TextEditingController();
//
  String? _selectedCourt; // // Variable for storing the selected Court
//

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  void _confirmGameDetails() {
    final String time = _timeController.text;
    if (time.isEmpty || _selectedCourt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Bitte füllen Sie alle Felder aus'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(
            'Das Spiel findet auf dem $_selectedCourt statt \n Startzeit: $time'),
      ),
    );
  }

  void _resetGameDetails() {
    setState(() {
      _timeController.clear(); // Time clearing
      _selectedCourt = null; // Reset selected site
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Alle Felder wurden zurückgesetzt'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Spielplanung", style: TextStyle(fontSize: 20)),
            //____________________________________________________________
            const SizedBox(height: 10),
            //____________________________________________________________
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 3,
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Startzeit',
                  hintText: 'Wählen Sie die Uhrzeit aus',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => _pickTime(context),
                  ),
                ),
                readOnly: true,
              ),
            ),
            //____________________________________________________________
            const SizedBox(height: 16),
            //____________________________________________________________
            Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              width: 800,
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: courts.length,
                itemBuilder: (BuildContext context, int index) {
                  final court = courts[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCourt = court.name;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${court.name} ausgewählt')),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      width: 300,
                      color: _selectedCourt == court.name
                          ? const Color.fromARGB(234, 1, 163, 82)
                          : const Color.fromARGB(255, 214, 246, 226),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              court.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              court.imageUrl,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Standort: ${court.locationUrl}",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            //____________________________________________________________
            const SizedBox(height: 16),
            //____________________________________________________________
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _confirmGameDetails,
                  child: const Text('Bestätigen'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetGameDetails,
                  style: ElevatedButton.styleFrom(iconColor: Colors.red),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
