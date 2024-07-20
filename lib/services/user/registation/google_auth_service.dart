import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService extends StatelessWidget {
  const GoogleAuthService({super.key});

  

 static Future<User?> signWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: unused_local_variable
      final User? user = userCredential.user;
    // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
