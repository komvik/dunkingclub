import 'package:dunkingclub/feature/players/models/player.dart';
import 'package:flutter/material.dart';

class AvailabilityChips extends StatefulWidget {
  const AvailabilityChips({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  State<AvailabilityChips> createState() => _AvailabilityChipsState();
}

class _AvailabilityChipsState extends State<AvailabilityChips> {
  String? selectedStatus; // container

  // function get color
  Color _getChipColor(String status) {
    if (status == selectedStatus) {
      // Если чип выбран, он яркий
      return status == 'Ja'
          ? Colors.green[300]!
          : status == 'Vielleicht'
              ? Colors.orange[300]!
              : Colors.red[300]!;
    }
    return Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: widget.player.availability.map((status) {
        return GestureDetector(
          onTap: () {
            setState(() {
              // change status when click
              if (selectedStatus == status) {
                selectedStatus = null;
              } else {
                selectedStatus = status;
              }
            });
          },
          child: Chip(
            label: Text(
              status,
              style: const TextStyle(fontSize: 10),
            ),
            backgroundColor: _getChipColor(status), //set color
          ),
        );
      }).toList(),
    );
  }
}
