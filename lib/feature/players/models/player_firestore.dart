import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

import 'package:dunkingclub/feature/players/models/player.dart';
import 'package:dunkingclub/feature/players/repositories/player_repository_firebase.dart';

class FirestorePlayerRepository implements PlayerRepositoryFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Player?> getPlayerByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('players')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return Player.fromMap(snapshot.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      dev.log("Error fetching player by email: $e");
      return null;
    }
  }

  @override
  Future<void> createPlayer(Player player) async {
    try {
      await _firestore.collection('players').add(player.toMap());
    } catch (e) {
      dev.log("Error creating player: $e");
      throw Exception("Failed to create player");
    }
  }

  @override
  Future<void> updatePlayer(Player player) async {
    try {
      final playerDoc = await _firestore
          .collection('players')
          .where('email', isEqualTo: player.eMail)
          .limit(1)
          .get();

      if (playerDoc.docs.isNotEmpty) {
        await _firestore
            .collection('players')
            .doc(playerDoc.docs.first.id)
            .update(player.toMap());
      }
    } catch (e) {
      dev.log("Error updating player: $e");
    }
  }

  @override
  Future<void> deletePlayerByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('players')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await _firestore
            .collection('players')
            .doc(snapshot.docs.first.id)
            .delete();
      }
    } catch (e) {
      dev.log("Error deleting player by email: $e");
    }
  }

  @override
  Future<List<Player>> loadAllPlayers() async {
    try {
      final snapshot = await _firestore.collection('players').get();
      return snapshot.docs.map((doc) => Player.fromMap(doc.data())).toList();
    } catch (e) {
      dev.log("Error loading all players: $e");
      return [];
    }
  }
}
