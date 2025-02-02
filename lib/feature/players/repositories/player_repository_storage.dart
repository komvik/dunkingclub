import 'package:dunkingclub/feature/players/models/player.dart';

abstract class PlayerRepositoryStorage {
  Future<void> savePlayers(List<Player> players);
  Future<List<Player>> loadPlayers();
  Future<Player?> getPlayerByEmail(String email);
  Future<void> deletePlayerByEmail(String email);
}
