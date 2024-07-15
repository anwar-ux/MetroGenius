import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/screens/User_login/user_register.dart';
import 'package:metrogeniusorg/src/screens/User_login/widgets/divider.dart';
import 'package:metrogeniusorg/src/screens/User_login/widgets/fbgoogle_login.dart';
import 'package:metrogeniusorg/src/screens/home/bottom_navigation.dart';
import 'package:metrogeniusorg/src/widgets/login_button.dart';
import 'package:metrogeniusorg/src/widgets/login_textfield.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

// ignore: must_be_immutable
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