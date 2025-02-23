import 'package:dunkingclub/feature/courts/repositories/court_data.dart';
import 'package:dunkingclub/feature/game_planning/models/game_item.dart';
import 'package:dunkingclub/feature/players/repositories/player_list_players_formockdb.dart';

List<Game> games = [
  Game(
    court: courts[0],
    team: [
      players[0],
      players[3],
    ],
    gameDate: DateTime.parse("2024-11-15 19:30:00"),
  ),
  Game(
    court: courts[0],
    team: [
      players[0],
      players[3],
    ],
    gameDate: DateTime.parse("2024-11-15 19:30:00"),
  ),
];
