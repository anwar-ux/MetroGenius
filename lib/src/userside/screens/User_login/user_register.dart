import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/usersignup/user_signup_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/user_login.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/widgets/divider.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/widgets/fbgoogle_login.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
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
      body: BlocConsumer<UserSignupBloc, UserSignupState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signup successful')),
            );
            Navigator.of(context).push(createRoute(UserLogin()));
          } else if (state.status == FormStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMsg ?? 'Signup failed')),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
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
                      CustomTextfield(
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
                      CustomTextfield(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        onChanged: (value)=>context.read<UserSignupBloc>().add(EmailChanged(value)),
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
                      CustomTextfield(
                        focusNode: passwordFocusNode,
                        controller: passController,
                        onChanged: (value)=>context.read<UserSignupBloc>().add(PasswordChanged(value)),
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
                      CustomTextfield(
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
                      if (state.status == FormStatus.pending)
                        const CircularProgressIndicator()
                      else
                        CustomButton(
                          title: 'Register',
                          action: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<UserSignupBloc>()
                                  .add(FormSubmit());
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
                              Navigator.of(context)
                                  .push(createRoute(UserLogin()));
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
          );
        },
      ),
    );
  }
}
