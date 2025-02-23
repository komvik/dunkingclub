import 'package:dunkingclub/feature/navigat/navigation_wrapper.dart';
import 'package:dunkingclub/feature/players/models/player_firestore.dart';
import 'package:dunkingclub/feature/players/models/player_storage.dart';
import 'package:dunkingclub/feature/players/repositories/player_repository_firebase.dart';
import 'package:dunkingclub/feature/players/repositories/player_repository_storage.dart';
import 'package:dunkingclub/feature/registr/models/login_firebase.dart';
import 'package:dunkingclub/feature/registr/repositories/firebase_authentication_repository.dart';
import 'package:dunkingclub/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(); // Загружаем .env
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // Provider<MockDbRepositoryPlayer>(create: (_) => PlayerMockDB()),
        Provider<PlayerRepositoryStorage>(create: (_) => PlayerStorage()),
        Provider<FirebaseAuthenticationRepository>(
            create: (_) => LoginFirebase()),
        Provider<PlayerRepositoryFirebase>(
            create: (_) => FirestorePlayerRepository()),
      ],
      child: const MainApp(),
    ),
  );

  // runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      // home: const AuthScreen(),
      //

      //  debug _  modus1
      home: const NavigationWrapper(),
      //
      // debug _  modus2
      // home: const RegistrationScreen(
      //   email: "email",
      //   password: "password",
      //   continent: "eu",
      //   country: "country",
      //   cityCode: "cityCode",
      // ),
    );
  }
}
