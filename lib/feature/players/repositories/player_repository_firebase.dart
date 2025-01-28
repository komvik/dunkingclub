import 'package:dunkingclub/feature/players/models/player.dart';

abstract class PlayerRepositoryFirebase {
  Future<Player?> getPlayerByEmail(String email);

  Future<void> createPlayer(Player player);

  Future<void> updatePlayer(Player player);

  Future<void> deletePlayerByEmail(String email);

  Future<List<Player>> loadAllPlayers();
}
