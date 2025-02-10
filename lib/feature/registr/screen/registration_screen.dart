import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dunkingclub/feature/navigat/navigation_wrapper.dart';
import 'package:dunkingclub/feature/players/models/player.dart';
import 'package:dunkingclub/feature/players/repositories/player_avatar_images.dart';
import 'package:dunkingclub/feature/players/repositories/player_repository_storage.dart';
import 'package:dunkingclub/feature/registr/repositories/firebase_authentication_repository.dart';
import 'package:dunkingclub/feature/registr/widgets/custom_text_field.dart';
import 'package:dunkingclub/feature/registr/widgets/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final String email;
  final String continent;
  final String country;
  final String cityCode;
  final String password;

  const RegistrationScreen(
      {super.key,
      required this.email,
      required this.continent,
      required this.country,
      required this.cityCode,
      required this.password});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Variable to store the selected avatar
  String _selectedCategory = avatarCategories.keys.first;

  String _selectedAvatar = 'assets/images_avatar/freelogo/avatar1.png';
  String _email = "";
  String _continent = "";
  String _country = "";
  String _cityCode = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _selectedAvatar =
        'assets/images_avatar/$_selectedCategory/${avatarCategories[_selectedCategory]!.first}';
    _email = widget.email;
    _continent = widget.continent;
    _country = widget.country;
    _cityCode = widget.cityCode;
    _password = widget.password;
    _loadPlayers();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastname = TextEditingController();
  final TextEditingController _controllerNickname = TextEditingController();
  final TextEditingController _controllerMobilnum = TextEditingController();

  final bool _isFormSubmitted = false;

//_______________ Valid Name Nachname Spitzname
  String? isValidText(String? value) {
    if (value == null || value.isEmpty) return "Bitte ein text angeben";
    if (value.length < 4) return "text is to short (4 chars minimum)";
    return null;
  }

//======================================= SAVE DATA TO SHAREDPREFERENCES
  // ignore: unused_field
  List<Player> _players = [];
// abruffen alle exestierte players
  Future<void> _loadPlayers() async {
    // _players = await PlayerStorage.loadPlayers();
    _players = await context.read<PlayerRepositoryStorage>().loadPlayers();

    setState(() {});
  }

//signin
//eMail: _email,
// old password: _password,

  // Future<void> _authenticationPlayerInFireBase() async {
  //   await context
  //       .read<FirebaseAuthenticationRepository>()
  //       .createUser(_email, _password);
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const NavigationWrapper()));
  // }

//save old

  // Future<void> _addPlayers() async {
  //   final newPlayer = Player(
  //     eMail: _email,
  //     password: _password,
  //     firstName: _controllerName.text,
  //     lastName: _controllerLastname.text,
  //     nickName: _controllerNickname.text,
  //     avatarUrl: _selectedAvatar,
  //     mobileNumber: _controllerMobilnum.text,
  //   );
  //   setState(() {
  //     _players.add(newPlayer);
  //   });

  //   //    List<Player> players = [player];
  //   //    await PlayerStorage.savePlayers(_players);
  //   await context.read<StorageRepositoryPlayer>().savePlayers(_players);

  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const NavigationWrapper()));
  // }

// save new

  Future<void> _authenticationPlayerInFireBaseAndSaveData() async {
    try {
      await context
          .read<FirebaseAuthenticationRepository>()
          .createUser(_email, _password);

      await _addPlayers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error user registring."),
          ),
        );
      }
    }
  }

  Future<void> _addPlayers() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final playerRef = FirebaseFirestore.instance
            .collection('players')
            .doc(_continent)
            .collection(_country)
            .doc(_cityCode)
            .collection('team')
            .doc(user.uid);

        await playerRef.set({
          'email': _email,
          'firstName': _controllerName.text,
          'lastName': _controllerLastname.text,
          'nickName': _controllerNickname.text,
          'avatarUrl': _selectedAvatar,
          'mobileNumber': _controllerMobilnum.text,
          'uid': user.uid,
        });

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NavigationWrapper()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error saving data.")),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not authorized error!!!!!")),
      );
    }
  }

  // void _clearFields() {
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dunkingclub'),
      ),
      body: Form(
        key: _formKey,
//
//==========================================================================
//          P O R T R E T
//==========================================================================
//

        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              // Text oben
              const Text(
                "Erstelle deinen eigenen Avatar",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  //  categoryIcons[_selectedCategory] ?? const SizedBox.shrink(),

                  SizedBox(
                    width: 230, // Уменьшенная ширина Dropdown

                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            isDense: true, // Уменьшает высоту виджета
                            filled: true,
                            fillColor: Colors.grey[600],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                          ),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.blue),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                              _selectedAvatar =
                                  'assets/images_avatar/$_selectedCategory/${avatarCategories[_selectedCategory]!.first}';
                            });
                          },
                          items: avatarCategories.keys
                              .map<DropdownMenuItem<String>>((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Row(
                                children: [
                                  categoryIcons[key] ?? const SizedBox.shrink(),
                                  const SizedBox(width: 10),
                                  Text(key,
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                avatarCategories[_selectedCategory]!.length,
                            itemBuilder: (context, index) {
                              String avatarPath =
                                  'assets/images_avatar/$_selectedCategory/${avatarCategories[_selectedCategory]![index]}';
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAvatar = avatarPath;
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        ExactAssetImage(avatarPath),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  CircleAvatar(
                    radius: 55,
                    backgroundImage: ExactAssetImage(_selectedAvatar),
                  ),
                ],
              ),

              // ==========================================================  Begin TextFields
              // ___________________________________________________________________ Name

              const SizedBox(height: 15),

              CustomTextField(
                controller: _controllerName,
                label: 'Name',
                icon: Icons.account_circle,
                errorText: _isFormSubmitted
                    ? validateFirstName(_controllerName.text)
                    : null,
              ),

              // ________________________________________________________________ Nachname

              CustomTextField(
                controller: _controllerLastname,
                label: 'Lastname',
                icon: Icons.account_circle,
                errorText: _isFormSubmitted
                    ? validateLastName(_controllerLastname.text)
                    : null,
              ),

              // ______________________________________________________ Spitzname Handynummer
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _controllerNickname,
                      label: 'Nickname (optional)',
                      icon: Icons.tag_faces,
                      errorText: _isFormSubmitted
                          ? validateNickname(_controllerNickname.text)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8), // Небольшой отступ между полями
                  Expanded(
                    child: CustomTextField(
                      controller: _controllerMobilnum,
                      label: 'Mobilnum (optional)',
                      icon: Icons.phone_android_outlined,
                      errorText: _isFormSubmitted
                          ? validateMobilnum(_controllerMobilnum.text)
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // ____________________________________________________________ Button Register

              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _authenticationPlayerInFireBaseAndSaveData();
                      //_addPlayers();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                              child: Text("Daten erfolgreich gespeichert.")),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          margin: EdgeInsets.only(bottom: 70.0),
                          content: Center(
                              child: Text("Daten müssen korrigiert werden.")),
                        ),
                      );
                    }
                  },
                  child: const Text("Register"),
                ),
              ),
              // ____________________________________________________________ Button Register
            ],
          ),
        ),
      ),
    );
  }
}
