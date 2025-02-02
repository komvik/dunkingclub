import 'package:dunkingclub/feature/players/models/player.dart';
import 'package:dunkingclub/feature/players/repositories/player_repository_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerStorage implements PlayerRepositoryStorage {
  @override
  Future<void> deletePlayerByEmail(String email) async {
    List<Player> players = await loadPlayers();
    players.removeWhere((player) => player.eMail == email);
    await savePlayers(players);
  }

  @override
  Future<Player?> getPlayerByEmail(String email) async {
    List<Player> players = await loadPlayers();
    try {
      return players.firstWhere((player) => player.eMail == email);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Player>> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    String? playersJson = prefs.getString("players");
    return Player.decodePlayers(playersJson!);
  }

  @override
  Future<void> savePlayers(List<Player> players) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedPlayers = Player.encodePlayers(players);
    await prefs.setString("players", encodedPlayers);
  }
}
