import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/user/registation/google_auth_service.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bottom_navigation.dart';

class FbGoogleLogin extends StatelessWidget {
  FbGoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 65,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 214, 214, 214)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Image.network(
            'https://clipground.com/images/facebook-icon-logo-8.png',
            height: 45,
            width: 45,
          )),
        ),
        GestureDetector(
          onTap: () async {
            User? user = await GoogleAuthService.signInWithGoogle();
            if (user != null) {
              Navigator.of(context)
                  .pushReplacement(createRoute(const BottomNavigation()));
            } else {
              print('Sign in failed');
            }
          },
          child: Container(
            height: 65,
            width: 120,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 214, 214, 214)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: Image.network(
              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
              height: 45,
              width: 45,
            )),
          ),
        )
      ],
    );
  }
}
