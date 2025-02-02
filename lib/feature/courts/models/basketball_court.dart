import 'dart:developer';

import 'package:dunkingclub/feature/courts/repositories/database_repository_court.dart';
import 'package:dunkingclub/feature/players/models/player.dart';

class BasketballCourt {
  String name;
  String location;
  Map<String, List<Player>> schedule =
      {}; // Key is time, value is a list of players playing at that time.

  BasketballCourt(this.name, this.location);

  // Indicate the place and time where they are going to play
  void indicatePlayTime(Player player, String time) {
    if (!schedule.containsKey(time)) {
      schedule[time] = [];
    }
    schedule[time]?.add(player);
    log("${player.eMail} will play at $name on $time.");
  }

  // Get information: See who is playing at what time
  void getPlayersAtTime(String time) {
    if (schedule.containsKey(time)) {
      log("\nPlayers playing at $name on $time: ${schedule[time]?.map((p) => p.eMail).join(', ')}\n");
    } else {
      log("No players scheduled for $time at $name.");
    }
  }

  // Plan future games
  void planFutureGame(Player player, String time) {
    indicatePlayTime(player, time);
    log("${player.eMail} planned a future game at $name on $time.");
  }

  // Save or update the court in the repository
  void saveCourt(DatabaseRepositoryCourt repository) {
    repository.addCourt(this);
  }

  // Delete the court from the repository
  void deleteCourt(DatabaseRepositoryCourt repository) {
    repository.deleteCourt(name);
    log("Court $name deleted from the repository.");
  }
}
