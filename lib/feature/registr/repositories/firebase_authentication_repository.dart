import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthenticationRepository {
  final authInstance = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => authInstance.authStateChanges();

  /// checking presence user in the DB with all sorts of technical errors
  Future<String?> checkIfUserExists(String email, String password);

  /// createUser  -> createUserWithEmailAndPassword (email,password)
  Future<void> createUser(String email, String password);

  /// Login -> signInWithEmailAndPassword (email,password)
  Future<void> loginUser(String email, String password);

  /// Logout ->  signOut()
  Future<void> logoutUser();

  /// Reset Password -> sendPasswordResetEmail(email)
  Future<void> resetPassword(String email);

  /// Update Password ->updatePassword(newPassword)
  Future<void> updatePassword(String newPassword);

  /// Getting the current user
  Future<User?> getCurrentUser();

  /// Login with Google
  Future<dynamic> signInWithGoogle();

  /// Logout with Google
  Future<void> signOutFromGoogle();
}
