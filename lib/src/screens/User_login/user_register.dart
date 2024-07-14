import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/services/google_auth_service.dart';
import 'package:metrogeniusorg/src/screens/User_login/user_login.dart';
import 'package:metrogeniusorg/src/widgets/login_button.dart';
import 'package:metrogeniusorg/src/widgets/login_textfield.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

// ignore: must_be_immutable
class UserRegister extends StatelessWidget {
  UserRegister({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final conPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seconderyColor,
      body: GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          passwordFocusNode.unfocus();
          usernameFocusNode.unfocus();
          conPasswordFocusNode.unfocus();
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
                  const Text(
                    'Hello! Register to get started',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Constants.spaceHight40,
                  LoginTextfield(
                    focusNode: usernameFocusNode,
                    controller: nameController,
                    hint: 'Username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your username';
                      }
                      return null;
                    },
                  ),
                  Constants.spaceHight20,
                  LoginTextfield(
                    focusNode: emailFocusNode,
                    controller: emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
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
                    focusNode: passwordFocusNode,
                    controller: passController,
                    hint: 'Password',
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
                  Constants.spaceHight20,
                  LoginTextfield(
                    focusNode: conPasswordFocusNode,
                    hint: 'Confirm password',
                    suffix: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      }
                      if (value != passController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  Constants.spaceHight20,
                  LoginButton(
                    title: 'Login',
                    action: () async {
                      try {
                        if (_formKey.currentState!.validate()) {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text,
                          );
                        }
                      } catch (e) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Constants.spaceHight40,
                  LoginDivider(
                    text: 'Or Register with',
                  ),
                  Constants.spaceHight20,
                   FbGoogleLogin(),
                  Constants.spaceHight50,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(createRoute(UserLogin()));
                        },
                        child: const Text(
                          'Login Now',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
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
