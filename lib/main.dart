import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusorg/firebase_options.dart';
import 'package:metrogeniusorg/services/employee/registation/employee_jobapllication.dart';
import 'package:metrogeniusorg/services/user/registation/user_signup_auth.dart';
import 'package:metrogeniusorg/src/employee/screens/register/bloc/employee_job_application_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/forgotpassword/forgot_password_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/user_signin/user_signin_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/User_login/bloc/usersignup/user_signup_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/getstart/common_login_page.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/getcategory_bloc.dart';
import 'package:metrogeniusorg/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserSignupBloc(UserSignupAuth()),
        ),
        BlocProvider(
          create: (context) => UserSigninBloc(),
        ),
        BlocProvider(
          create: (context) => EmployeeJobApplicationBloc(EmployeeJobapllication()),
        ),
        BlocProvider(
          create: (context) => GetcategoryBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
        ),
      ],
      child: MaterialApp(
        color: AppColors.primaryColor,
        theme: ThemeData(textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        home: const CommonLoginPage(),
      ),
    );
  }
}
