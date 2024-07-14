import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/google_auth_service.dart';
import 'package:metrogeniusorg/src/screens/User_login/user_register.dart';
import 'package:metrogeniusorg/src/screens/home/bottom_navigation.dart';
import 'package:metrogeniusorg/src/widgets/login_button.dart';
import 'package:metrogeniusorg/src/widgets/login_textfield.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seconderyColor,
      body: GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Constants.spaceHight50,
                  Constants.spaceHight50,
                  const Text(
                    'Welcome back! Glad to see you, Again!',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Constants.spaceHight40,
                  LoginTextfield(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    hint: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      // Basic email validation regex
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  Constants.spaceHight20,
                  LoginTextfield(
                    controller: passController,
                    focusNode: passwordFocusNode,
                    hint: 'password',
                    suffix: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  Constants.spaceHight10,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black87),
                      )
                    ],
                  ),
                  Constants.spaceHight20,
                  LoginButton(
                    title: 'Login',
                    action: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text,
                          ) .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('SIgning you in')));
                                  Navigator.of(context)
                            .push(createRoute(const BottomNavigation()));
                          }).onError((error,stackTree){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid User'),backgroundColor: Colors.red,),);
                          });
                        } catch (e) {
                          print(e);
                        }

                      }
                    },
                  ),
                  Constants.spaceHight40,
                  LoginDivider(
                    text: 'or Login with',
                  ),
                  Constants.spaceHight20,
                   FbGoogleLogin(),
                  Constants.spaceHight50,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don’t have an account?'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(createRoute(UserRegister()));
                        },
                        child: const Text(
                          'Register Now',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
          onTap:()
            async {
            User? user = await GoogleAuthService.signWithGoogle();
            if (user != null) {
              print('Signed in as ${user.displayName}');
            } else {
              print('Sign in failed');
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
            )),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class LoginDivider extends StatelessWidget {
  LoginDivider({
    super.key,
    required this.text,
  });

  String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            indent: 10,
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
        Constants.spaceWidth10,
        Text(text),
        Constants.spaceWidth10,
        const Expanded(
          child: Divider(
            endIndent: 10,
            color: Color.fromARGB(255, 214, 214, 214),
          ),
        ),
      ],
    );
  }
}
