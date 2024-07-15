import 'package:firebase_auth/firebase_auth.dart';

class UserSignupAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential  creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return creds.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return null;
    }
  }
}
