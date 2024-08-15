import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/employee/employee_bottom_navigation.dart';
import 'package:metrogeniusorg/src/employee/screens/home/employee_home.dart';
import 'package:metrogeniusorg/src/employee/screens/login/bloc/bloc/employee_login_bloc.dart';
import 'package:metrogeniusorg/src/widgets/circular.dart';
import 'package:metrogeniusorg/src/widgets/custom_button.dart';
import 'package:metrogeniusorg/src/widgets/custom_textfield.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/constants.dart';
import 'package:metrogeniusorg/utils/validations.dart';

class EmployeeLogin extends StatelessWidget {
  EmployeeLogin({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<EmployeeLoginBloc, EmployeeLoginState>(
          listener: (context, state) {
            if (state.status == FormStatus.success) {
              showCustomSnackbar(context, 'Succes', 'Login Successfull', Colors.green);
            } else if (state.status == FormStatus.error) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMsg!)),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Constants.spaceHight50,
                  Constants.spaceHight50,
                  const Text(
                    'Welcome ! Glad to see you',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Constants.spaceHight40,
                  CustomTextfield(
                    onChanged: (value) => context.read<EmployeeLoginBloc>().add(EmailChanged(value)),
                    hint: 'Enter your email',
                    validator: Validations.email,
                  ),
                  Constants.spaceHight20,
                  CustomTextfield(
                    onChanged: (value) => context.read<EmployeeLoginBloc>().add(PasswordChanged(value)),
                    hint: 'Enter your employee code',
                    obscureText: true,
                    suffix: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                    ),
                    validator: Validations.password,
                  ),
                  Constants.spaceHight40,
                  CustomButton(
                    title: 'Login',
                    width: double.infinity,
                    action: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<EmployeeLoginBloc>().add(FormSubmit());
                        Navigator.of(context).push(createRoute(const EmployeeBottomNavigation()));
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
