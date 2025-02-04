import "dart:convert";

class Player {
  final String userId;
  final String eMail;
  final String continent;
  final String country;
  final String cityCode;
  final String password;
  final String firstName;
  final String lastName;
  final String nickName;
  final String avatarUrl;
  final List<String> availability;
  final bool sendMessage;
  final bool online;
  final String mobileNumber;

  Player({
    this.userId = "",
    required this.eMail,
    required this.continent,
    required this.country,
    required this.cityCode,
    required this.password,
    this.firstName = "Max",
    this.lastName = "Mustermann",
    this.nickName = "-",
    this.avatarUrl = "assets/images_avatar/avatar1.png",
    this.availability = const ['Ja', 'Vielleicht', 'Nein'],
    this.sendMessage = false,
    this.online = false,
    this.mobileNumber = "-",
  });

// serelisirung
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'eMail': eMail,
      'continent': continent,
      'country': country,
      'cityCode': cityCode,
      'password': password,
      'avatarUrl': avatarUrl,
      'availability': availability,
      'sendMessage': sendMessage,
      'online': online,
      'mobilNumber': mobileNumber,
    };
  }

  // de serelisirung
  static Player fromJson(Map<String, dynamic> json) {
    return Player(
      userId: json['userId'] ?? "",
      firstName: json['firstName'] ?? "Max",
      lastName: json['lastName'] ?? "Mustermann",
      nickName: json['nickName'] ?? "-",
      eMail: json['eMail'] ?? "example@email.mail",
      continent: json['continent'] ?? "",
      country: json['country'] ?? "",
      cityCode: json['cityCode'] ?? "",
      password: json['password'] ?? "",
      avatarUrl: json['avatarUrl'] ?? "assets/images_avatar/avatar1.png",
      availability: List<String>.from(json['availability'] ?? []),
      sendMessage: json['sendMessage'] ?? false,
      online: json['online'] ?? false,
      mobileNumber: json['mobileNumber'] ?? "-",
    );
  }

  // player->to json
  static String encodePlayers(List<Player> players) {
    List<Map<String, dynamic>> playerMaps =
        players.map((player) => player.toJson()).toList();
    return jsonEncode(playerMaps);
  }

  // json->to player
  static List<Player> decodePlayers(String playersJson) {
    List<dynamic> playerList = jsonDecode(playersJson);
    return playerList.map((playerJson) => Player.fromJson(playerJson)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'eMail': eMail,
      'continent': continent,
      'country': country,
      'cityCode': cityCode,
      'avatarUrl': avatarUrl,
      'availability': availability,
      'sendMessage': sendMessage,
      'online': online,
      'mobileNumber': mobileNumber,
      // 'password' not saved
    };
  }

  static Player fromMap(Map<String, dynamic> map, {String? password}) {
    return Player(
      userId: map['userId'] ?? "",
      firstName: map['firstName'] ?? "Max",
      lastName: map['lastName'] ?? "Mustermann",
      nickName: map['nickName'] ?? "-",
      eMail: map['eMail'] ?? "example@email.mail",
      continent: map['continent'] ?? "",
      country: map['country'] ?? "",
      cityCode: map['cityCode'] ?? "",
      password: password ?? "",
      avatarUrl: map['avatarUrl'] ?? "assets/images_avatar/avatar1.png",
      availability: List<String>.from(map['availability'] ?? []),
      sendMessage: map['sendMessage'] ?? false,
      online: map['online'] ?? false,
      mobileNumber: map['mobileNumber'] ?? "-",
    );
  }
}
