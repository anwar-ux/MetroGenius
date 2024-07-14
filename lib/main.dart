import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusorg/firebase_options.dart';
import 'package:metrogeniusorg/src/screens/getstart/common_login_page.dart';
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
    return  MaterialApp(
      color: AppColors.primaryColor,
      theme:ThemeData(
       textTheme:GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
      home: CommonLoginPage(),
    );
  }
}
