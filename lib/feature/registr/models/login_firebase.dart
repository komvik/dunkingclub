import 'dart:developer' as dev;
import 'package:dunkingclub/feature/registr/repositories/firebase_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFirebase implements FirebaseAuthenticationRepository {
  @override
  final authInstance = FirebaseAuth.instance;

  @override
  Stream<User?> get onAuthStateChanged => authInstance.authStateChanges();

  //PRIMENENIE
// onAuthStateChanged.listen((User? user) {
//   if (user != null) {
//     // Пользователь вошел в систему
//     print('Пользователь вошел: ${user.email}');
//   } else {
//     // Пользователь вышел из системы
//     print('Пользователь не аутентифицирован');
//   }
// });

//Пример функции для проверки наличия пользователя:

// Future<User?> signInUser(String email, String password) async {
//   try {
//     final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user; // Возвращаем объект User, если пользователь найден
//   } catch (e) {
//     print('Error during sign-in: $e');
//     return null; // Возвращаем null, если возникла ошибка, например, неправильный email или пароль
//   }
// }

// 3 // _____ checking presence user in the DB with all sorts of technical errors
  @override
  Future<String?> checkIfUserExists(String email, String password) async {
    String firebaseAuthAnswer =
        ""; // Variable to store the result of authentication
    // Переменная для хранения результата аутентификации

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        firebaseAuthAnswer = "user_found";
        // Пользователь найден
      }
      return firebaseAuthAnswer;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        // Пользователь с таким email не найден.
        case 'user-not-found':
          firebaseAuthAnswer = ('User with this email not found.');
          break;

        // Неверный пароль.
        case 'wrong-password':
          firebaseAuthAnswer = ('Incorrect password');
          break;

        // Некорректный формат email.
        case 'invalid-email':
          firebaseAuthAnswer = ('Invalid email format.');
          break;

        // Аккаунт пользователя был отключен.
        case 'user-disabled':
          firebaseAuthAnswer = ('User account has been disabled.');
          break;

        // Метод аутентификации с email и паролем не включен в Firebase.
        case 'operation-not-allowed':
          firebaseAuthAnswer =
              ('Email/password authentication method is not enabled in Firebase.');
          break;

        // Слишком много попыток входа. Пожалуйста, подождите.
        case 'too-many-requests':
          firebaseAuthAnswer = ('Too many login attempts. Please wait.');
          break;

        // Ошибка сети. Пожалуйста, проверьте подключение к интернету.
        case 'network-request-failed':
          firebaseAuthAnswer =
              ('Network error. Please check your internet connection.');
          break;

        // Внутренняя ошибка сервера Firebase.
        case 'internal-error':
          firebaseAuthAnswer = ('Internal Firebase server error.');
          break;

        // Неизвестная ошибка: ${e.message}
        default:
          firebaseAuthAnswer = ('Unknown error');
      }
      return firebaseAuthAnswer;
    }
  }

  // 4 // ________Create user (sign up)
  @override
  Future<void> createUser(String email, String password) async {
    try {
      await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      dev.log("SignUp error: $e");
      throw Exception("Error during sign up: $e");
    }
  }

  // 5 //___________Login
  @override
  Future<void> loginUser(String email, String password) async {
    try {
      await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      dev.log("Login error: $e");
      throw Exception("Error during login: $e");
    }
  }

  // 6 //________ Logout
  @override
  Future<void> logoutUser() async {
    try {
      await authInstance.signOut();
    } catch (e) {
      dev.log("Logout error: $e");
    }
  }

  // 7 //________ Reset Password
  @override
  Future<void> resetPassword(String email) async {
    try {
      await authInstance.sendPasswordResetEmail(email: email);
      dev.log("Password reset email sent to $email");
    } catch (e) {
      dev.log("Reset password error: $e");
      throw Exception("Error during password reset: $e");
    }
  }

  // 8 // ________ Update Password
  @override
  Future<void> updatePassword(String newPassword) async {
    User? user = authInstance.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        dev.log("Password updated successfully.");
      } catch (e) {
        dev.log("Error updating password: $e");
        throw Exception("Error updating password: $e");
      }
    } else {
      dev.log("No user signed in.");
    }
  }

// 9 // _______ Getting the current user
  @override
  Future<User?> getCurrentUser() async {
    try {
      User? currentUser = authInstance.currentUser;
      if (currentUser == null) {
        dev.log("User is no signed in.");
      } else {
        dev.log("Current user signed in with email : ${currentUser.email}");
      }
      return currentUser;
    } catch (e) {
      dev.log("Error current user: $e");
      return null;
    }
  }

//
//______________G O O G L E _________
//
// logIn with Google
  @override
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        dev.log("User cancelled authorization");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await authInstance.signInWithCredential(credential);
    } on Exception catch (e) {
      dev.log("Google sign-in error: $e");
    }
  }

// logOut with Google
  @override
  Future<void> signOutFromGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await authInstance.signOut();
    } on Exception catch (e) {
      dev.log("Google sign-out error: $e");
    }
  }
}
