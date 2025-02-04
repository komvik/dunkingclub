import 'dart:developer';
import 'package:dunkingclub/feature/players/models/player.dart';
import 'package:dunkingclub/feature/players/repositories/player_repository_firebase.dart';
import 'package:dunkingclub/feature/players/screens/availability_chips.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPlayersScreen extends StatefulWidget {
  const InfoPlayersScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InfoPlayersScreenState createState() => _InfoPlayersScreenState();
}

class _InfoPlayersScreenState extends State<InfoPlayersScreen> {
  List<Player> _players = [];
  int _currentPlayerIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

// Load Alle player
//__________________________________________________________________
  Future<void> _loadPlayers() async {
    //List<Player> loadedPlayers = await PlayerStorage.loadPlayers();
    List<Player> loadedPlayers =
        //await context.read<PlayerRepositoryStorage>().loadPlayers();
        await context.read<PlayerRepositoryFirebase>().loadAllPlayers();
    setState(() {
      _players = loadedPlayers;
    });
  }

//Move to the next player
//__________________________________________________
  // ignore: unused_element
  void _nextPlayer() {
    setState(() {
      if (_currentPlayerIndex < _players.length - 1) {
        _currentPlayerIndex++;
      } else {
        log("check completed");
      }
    });
  }

// Delete player by index
//__________________________________________________________________
  Future<void> _deletePlayerByIndex(int index) async {
    // löshe ich player aus der liste per index
    final playerToDelete = _players[index];
    setState(() {
      _players.removeAt(index);
    });
    // danach speichere vieder alles
    //aawait PlayerStorage.savePlayers(_players);
    await context
        .read<PlayerRepositoryFirebase>()
        .deletePlayerByEmail(playerToDelete.eMail);

    // zeige status
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "${playerToDelete.firstName} ${playerToDelete.lastName} DELETED!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _players.length,
      itemBuilder: (context, index) {
        final player = _players[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //___________________________________ Online status indicator
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Circular status indicator
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: player.online ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          player.online ? "Online" : "Offline",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    const SizedBox(width: 8), // Space between status and avatar

                    // ________________________________________  AVATAR
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: player.avatarUrl.isNotEmpty
                          ? AssetImage(player.avatarUrl)
                          : const AssetImage(
                              "assets/images_avatar/avatar1.png"),
                    ),
                    const SizedBox(width: 8),

                    //__________________________________________ INFO PLAYER
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${player.firstName} ${player.lastName}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " ${player.nickName}", //Nickname
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                          // ________________________  Availability
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 130, 127, 223)),
                      onPressed: () => _deletePlayerByIndex(index),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AvailabilityChips(player: player),
              ],
            ),
          ),
        );
      },
    );
  }
}
