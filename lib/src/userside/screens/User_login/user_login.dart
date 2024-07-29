import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/user_signin/user_signin_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/forgot_password.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/user_register.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/widgets/divider.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/widgets/fbgoogle_login.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bottom_navigation.dart';
import 'package:metrogeniusorg/src/widgets/circular.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';
import 'package:metrogeniusorg/utils/validations.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.seconderyColor,
      body: BlocConsumer<UserSigninBloc, UserSigninState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            showCustomSnackbar(context, 'Success', 'Login as \n${state.email}', Colors.green);
            Navigator.of(context).pushReplacement(createRoute(const BottomNavigation()));
          } else if (state.status == FormStatus.error) {
            showCustomSnackbar(context, 'Failed', 'invalid email or password', Colors.red);
          } else if (state.status == FormStatus.pending) {
            buildShowDialog(context);
          }
        },
        builder: (context, state) {
          return GestureDetector(
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
                      CustomTextfield(
                          onChanged: (value) => context.read<UserSigninBloc>().add(EmailChanged(value)),
                          controller: emailController,
                          focusNode: emailFocusNode,
                          hint: 'Enter your email',
                          validator: Validations.email),
                      Constants.spaceHight20,
                      CustomTextfield(
                        controller: passController,
                        focusNode: passwordFocusNode,
                        onChanged: (value) => context.read<UserSigninBloc>().add(PasswordChanged(value)),
                        hint: 'Password',
                        obscureText: true,
                        suffix: const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 18,
                        ),
                        validator: Validations.password,
                      ),
                      Constants.spaceHight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(createRoute(ForgotPasswordPage())),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                      Constants.spaceHight20,
                      CustomButton(
                        title: 'Login',
                        action: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserSigninBloc>().add(FormSubmit());
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
                              Navigator.of(context).push(createRoute(UserRegister()));
                            },
                            child: const Text(
                              'Register Now',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
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
