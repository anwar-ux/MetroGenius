// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/user/registation/google_auth_service.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bottom_navigation.dart';
import 'package:metrogeniusorg/src/widgets/circular.dart';

class FbGoogleLogin extends StatelessWidget {
  FbGoogleLogin({Key? key}) : super(key: key);

  Future<void> _handleSignIn(BuildContext context) async {}

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
            buildShowDialog(context);
            User? user = await GoogleAuthService.signInWithGoogle();
            Navigator.of(context).pop();
            if (user != null) {
              Navigator.of(context).pushReplacement(createRoute(const BottomNavigation()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Google Sign-In failed')),
              );
            }
          },
          child: Container(
            height: 65,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 214, 214, 214)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.network(
                'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                height: 45,
                width: 45,
              ),
            ),
          ),
        )
      ],
    );
  }
}
