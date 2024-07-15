import 'package:firebase_auth/firebase_auth.dart';

class UserSigninAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final  userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          print('No user found for that email.');
          throw Exception('No user found for that email.');
        case 'wrong-password':
          print('Wrong password provided for that user.');
          throw Exception('Wrong password provided for that user.');
        case 'invalid-email':
          print('The email address is invalid.');
          throw Exception('The email address is invalid.');
        case 'user-disabled':
          print('User with this email has been disabled.');
          throw Exception('User with this email has been disabled.');
        case 'too-many-requests':
          print('Too many attempts. Try again later.');
          throw Exception('Too many attempts. Try again later.');
        default:
          print('An unknown error occurred: ${e.message}');
          throw Exception('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to sign in: $e');
      
    }
   
  }
}
