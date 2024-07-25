import 'package:firebase_auth/firebase_auth.dart';

class UserSigninAuth {

 static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is invalid.');
      } else {
        throw Exception('An unknown error occurred.');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

 static Future<bool> resetPassword(String email) async {
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
