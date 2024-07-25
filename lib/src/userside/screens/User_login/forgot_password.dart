import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/forgotpassword/forgot_password_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/user_login.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/utils/constants.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  TextEditingController emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              emailFocusNode.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.spaceHight50,
                  Constants.spaceHight50,
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Don't worry! It occurs. Please enter the email address linked with your account.",
                    style: TextStyle(
                        color: Color.fromARGB(255, 130, 130, 130),
                        fontSize: 16,
                        letterSpacing: 1),
                  ),
                  Constants.spaceHight35,
                  CustomTextfield(
                    onChanged: (value) => context
                        .read<ForgotPasswordBloc>()
                        .add(EmailChanged(value)),
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
                  Constants.spaceHight35,
                  CustomButton(
                    title: 'Submit',
                    action: () {
                      context.read<ForgotPasswordBloc>().add(FormSubmit());
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Remember Password?',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(createRoute(UserLogin())),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              letterSpacing: 1),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
